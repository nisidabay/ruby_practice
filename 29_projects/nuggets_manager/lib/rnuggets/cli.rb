# frozen_string_literal: true

require 'optparse'

module Rnuggets
  # CLI argument parser and command dispatcher using OptionParser.
  # Maps CLI flags to Nugget methods.
  class CLI
    def initialize
      @nugget = Nugget.new
    end

    # Parse +args+ (typically ARGV) and dispatch to the appropriate Nugget
    # method. Returns an exit code (0 for success, 1 for errors).
    #
    # @param args [Array<String>]
    # @return [Integer] exit code
    def run(args)
      action = nil

      parser = OptionParser.new do |opts|
        opts.banner = 'Usage: rnuggets [options]'
        opts.separator ''
        opts.separator 'Show code snippets and GNU tools'
        opts.separator ''
        opts.separator 'Options:'

        opts.on('-c', '--choose', 'Change default nugget') do
          action = :select_specific_nugget
        end

        opts.on('-d', '--delete', 'Delete nugget') do
          action = :delete_nugget
        end

        opts.on('-e', '--edit', 'Edit nugget') do
          action = :edit_nugget
        end

        opts.on('-f', '--find', 'Find word in nugget') do
          action = :find_in_nuggets
        end

        opts.on('-l', '--list', 'List available nuggets') do
          action = :show_available_nuggets
        end

        opts.on('-m', '--merge', 'Merge all nuggets in one file') do
          action = :merge_all_nuggets
        end

        opts.on('-n', '--new', 'Create new nugget') do
          action = :new_nugget
        end

        opts.on('-s', '--show', 'Show default nugget') do
          action = :show_selected_nugget
        end

        opts.on('-R', '--random', 'Random nugget') do
          action = :select_random_nugget
        end

        opts.on('--version', 'Show version') do
          puts "rnuggets #{Rnuggets::VERSION}"
          return 0
        end

        opts.on('-h', '--help', 'Show this help') do
          puts opts
          return 0
        end
      end

      begin
        parser.order!(args)
      rescue OptionParser::InvalidOption => e
        puts e
        puts parser
        return 1
      end

      if action
        @nugget.public_send(action)
      else
        @nugget.run_nuggets
      end

      0
    end
  end
end
