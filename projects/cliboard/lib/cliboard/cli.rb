# frozen_string_literal: true

require 'optparse'

module Cliboard
  # Command-line interface handler
  class CLI
    def initialize
      @data_dir = File.expand_path('~/.config/cliboard')

      # Initialize components with dependency injection
      @clipboard = Clipboard.detect
      @history = History.new(
        storage: Storage.new(File.join(@data_dir, 'history.json')),
        max_size: config.get('max_history')
      )
      @pins = PinnedItems.new(
        storage: Storage.new(File.join(@data_dir, 'pins.json'))
      )
      @display = Display.new(pins: @pins)
    end

    def config
      @config ||= Config.new(
        storage: ConfigStorage.new(File.join(@data_dir, 'config.json'))
      )
    end

    # Entry point
    # @param args [Array<String>] command-line arguments
    # @return [Integer] exit code
    def run(args)
      command = args.shift || 'history'

      case command
      when 'history', 'h' then cmd_history(args)
      when 'add' then cmd_add(args)
      when 'get' then cmd_get(args)
      when 'select', 's', 'copy', 'cp' then cmd_select(args)
      when 'pin', 'p' then cmd_pin(args)
      when 'unpin', 'up' then cmd_unpin(args)
      when 'pins' then cmd_pins(args)
      when 'search' then cmd_search(args)
      when 'clear', 'c' then cmd_clear(args)
      when 'watch' then cmd_watch(args)
      when 'config' then cmd_config(args)
      when 'help', '-h', '--help' then cmd_help(args)
      else cmd_unknown(command)
      end
    end

    private

    # Commands

    def cmd_history(args)
      limit = extract_number(args) || config.get('max_history') || 20

      if @history.empty?
        show_empty_help
        return 0
      end

      @display.show_history(@history.recent(limit), limit: limit)
      0
    end

    def cmd_add(_args)
      text = @clipboard.get

      if text.nil? || text.empty?
        puts "\e[31mClipboard is empty\e[0m"
        return 1
      end

      @history.add(text)
      puts "\e[32mAdded: #{text[0, 60]}\e[0m"
      0
    end

    def cmd_get(_args)
      text = @clipboard.get

      if text.nil?
        puts "\e[31mClipboard is empty\e[0m"
        return 1
      end

      puts text
      0
    end

    def cmd_select(args)
      index = extract_number(args)

      unless index
        puts 'Usage: cliboard select <number>'
        puts '       cliboard copy <number>'
        return 1
      end

      item = @history.get(index)

      if item.nil?
        puts "\e[31mItem #{index} not found\e[0m"
        return 1
      end

      if @clipboard.set(item['text'])
        puts "\e[32mCopied to clipboard\e[0m"
        puts item['text'][0, 100]
        0
      else
        puts "\e[31mFailed to copy\e[0m"
        1
      end
    end

    def cmd_pin(args)
      index = extract_number(args)

      unless index
        puts 'Usage: cliboard pin <number>'
        return 1
      end

      item = @history.get(index)

      if item.nil?
        puts "\e[31mItem #{index} not found\e[0m"
        return 1
      end

      @pins.pin(item['text'])
      puts "\e[32mPinned: #{item['text'][0, 50]}\e[0m"
      0
    end

    def cmd_unpin(args)
      index = extract_number(args)

      unless index
        puts 'Usage: cliboard unpin <number>'
        return 1
      end

      removed = @pins.unpin(index)

      if removed
        puts "\e[32mUnpinned: #{removed['text'][0, 50]}\e[0m"
        0
      else
        puts "\e[31mPin #{index} not found\e[0m"
        1
      end
    end

    def cmd_pins(_args)
      if @pins.empty?
        puts 'No pinned items'
      else
        @display.show_pins(@pins.items)
      end
      0
    end

    def cmd_search(args)
      query = args.join(' ')

      if query.empty?
        puts 'Usage: cliboard search <query>'
        return 1
      end

      results = @history.search(query)
      @display.show_search(query, results)
      0
    end

    def cmd_clear(_args)
      @history.clear
      puts "\e[32mClipboard history cleared\e[0m"
      0
    end

    def cmd_watch(_args)
      puts 'Watching clipboard... (Ctrl+C to stop)'
      puts 'Current clipboard content will be captured'
      puts

      # Capture initial content
      if (current = @clipboard.get)
        @history.add(current)
        puts "\e[32mCaptured: #{current[0, 60]}...\e[0m"
      end

      # Watch for changes
      @clipboard.watch do |text|
        @history.add(text)
        puts "\e[32mCaptured: #{text[0, 60]}...\e[0m"
      end

      0
    rescue Interrupt
      puts "\nStopped"
      0
    end

    def cmd_config(args)
      subcommand = args.shift

      case subcommand
      when 'set'
        cmd_config_set(args)
      when 'get'
        cmd_config_get(args)
      when 'list'
        cmd_config_list(args)
      when nil, 'help'
        cmd_config_help
      else
        puts "Unknown config command: #{subcommand}"
        puts "Use 'cliboard config help' for usage"
        1
      end
    end

    def cmd_config_set(args)
      key = args.shift
      value = args.shift

      if key.nil? || value.nil?
        puts 'Usage: cliboard config set <key> <value>'
        puts ''
        puts 'Keys:'
        puts '  max_history <N>  Maximum items in history (default: 100)'
        puts ''
        puts 'Example:'
        puts '  cliboard config set max_history 50'
        return 1
      end

      unless config.valid_key?(key)
        puts "Unknown config key: #{key}"
        puts "Valid keys: #{Config.valid_keys.join(', ')}"
        return 1
      end

      config.set(key, value)
      puts "\e[32mSet #{key} to #{value}\e[0m"
      0
    end

    def cmd_config_get(args)
      key = args.shift

      if key.nil?
        puts 'Usage: cliboard config get <key>'
        puts ''
        puts 'Keys:'
        Config.valid_keys.each { |k| puts "  #{k}" }
        return 1
      end

      unless config.valid_key?(key)
        puts "Unknown config key: #{key}"
        return 1
      end

      puts config.get(key)
      0
    end

    def cmd_config_list(_args)
      puts 'Current configuration:'
      puts JSON.pretty_generate(config.to_h)
      0
    end

    def cmd_config_help
      puts 'Config commands:'
      puts '  set <key> <value>  Set a configuration value'
      puts '  get <key>          Get a configuration value'
      puts '  list               Show all configuration values'
      puts ''
      puts 'Keys:'
      puts '  max_history  Maximum items in history (default: 100)'
      puts ''
      puts 'Examples:'
      puts '  cliboard config set max_history 50'
      puts '  cliboard config get max_history'
      puts '  cliboard config list'
      0
    end

    def cmd_help(_args)
      show_help
      0
    end

    def cmd_unknown(command)
      puts "Unknown command: #{command}"
      puts "Use 'cliboard --help' for usage"
      1
    end

    # Helpers

    def extract_number(args)
      args.find { |a| a.match?(/^\d+$/) }&.to_i
    end

    def show_empty_help
      puts 'No clipboard history'
      puts "Run 'cliboard watch' in background to capture clipboard"
      puts "Or run 'cliboard add' to add current clipboard content"
    end

    def show_help
      puts <<~HELP
        Usage: cliboard <command> [arguments]

        Commands:
          history          Show clipboard history
          add              Add current clipboard to history
          get              Print current clipboard content
          select <N>       Copy history item #N to clipboard
          copy <N>         Copy history item #N to clipboard
          pin <N>          Pin history item #N
          unpin <N>        Remove pin from item #N
          pins             Show pinned items
          search <query>   Search clipboard history
          clear            Clear all history
          watch            Watch clipboard for changes
          config           Manage configuration

        Config commands:
          config set <key> <value>  Set config value
          config get <key>          Get config value
          config list               Show all config

        Config keys:
          max_history  Maximum history items (default: 100)

        Examples:
          cliboard watch &           # Start clipboard watcher
          cliboard add               # Add current clipboard
          cliboard history           # Show history
          cliboard select 2          # Copy item #2
          cliboard pin 3             # Pin item #3
          cliboard config set max_history 50

        Options:
          -h, --help                 Show this help
      HELP
    end
  end
end
