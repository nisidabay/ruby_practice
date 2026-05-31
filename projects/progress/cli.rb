# frozen_string_literal: true

require "date"
require_relative "scanner"
require_relative "formatter"

# CLI - Command Line Interface for the progress tracker
#
# This class handles command-line arguments and invokes the appropriate
# scanner and formatter methods.
#
# Key concepts:
#   - OptionParser: Ruby's built-in argument parser
#   - ARGV: command-line arguments
#   - Time/Date: Ruby's time handling
#
class CLI
  # Main entry point - called by the executable
  #
  # @param args [Array<String>] command-line arguments (usually ARGV)
  # @return [void]
  #
  def self.run(args = ARGV)
    options = parse_args(args)
    files = Scanner.scan(
      from_date: options[:from_date],
      to_date: options[:to_date],
      directory: options[:directory]
    )

    if options[:format] == :json
      # JSON output - for scripts/piping
      puts Formatter.format_json(files)
    else
      # TUI output - interactive (lazy load curses)
      require_relative "tui"
      TUI.new(files, from_date: options[:from_date], to_date: options[:to_date]).run
    end
  end

  private

  # Parse command-line arguments
  #
  # @param args [Array<String>] command-line arguments
  # @return [Hash] {from_date:, to_date:, format:, directory:}
  #
  def self.parse_args(args)
    options = {}

    # Handle subcommands first (today, yesterday, week)
    if args.first == "today"
      options[:from_date] = Date.today
      options[:to_date] = Date.today
      args.shift
    elsif args.first == "yesterday"
      options[:from_date] = Date.today - 1
      options[:to_date] = Date.today - 1
      args.shift
    elsif args.first == "week"
      options[:from_date] = Date.today - 7
      options[:to_date] = Date.today
      args.shift
    end

    # Parse remaining options
    require "optparse"
    OptionParser.new do |opts|
      opts.banner = "Usage: progress [today|yesterday|week] [options]"
      opts.separator ""
      opts.separator "Commands:"
      opts.separator "  today      Show files modified today"
      opts.separator "  yesterday  Show files modified yesterday"
      opts.separator "  week       Show files modified in last 7 days"
      opts.separator ""
      opts.separator "Options:"

      opts.on("--from DATE", String, "Start date (YYYY-MM-DD)") do |date|
        options[:from_date] = Date.parse(date)
      end

      opts.on("--to DATE", String, "End date (YYYY-MM-DD)") do |date|
        options[:to_date] = Date.parse(date)
      end

      opts.on("--dir DIRECTORY", String, "Override scan directory") do |dir|
        options[:directory] = dir
      end

      opts.on("--format FORMAT", String, "Output format: tui (default), json") do |fmt|
        options[:format] = fmt.to_sym
      end

      opts.on("-h", "--help", "Show this help") do
        puts opts
        exit
      end
    end.parse!(args)

    # Default: show today if no date specified
    options[:from_date] ||= Date.today
    options[:to_date] ||= Date.today
    options[:format] ||= :tui

    options
  end
end
