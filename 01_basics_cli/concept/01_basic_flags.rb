#!/usr/bin/env ruby
# 01_basic_flags.rb - Introduction to boolean flags
# Run: ruby 01_basic_flags.rb -h
#      ruby 01_basic_flags.rb -v
#      ruby 01_basic_flags.rb --verbose --debug

require 'optparse'

options = {
  verbose: false,
  debug: false,
  quiet: false
}

OptionParser.new do |opts|
  opts.banner = 'Usage: 01_basic_flags.rb [options]'
  opts.separator ''
  opts.separator "Basic boolean flags - options that don't take arguments"
  opts.separator ''

  # Simple flag - just sets a value to true when present
  opts.on('-v', '--verbose', 'Enable verbose output') do
    options[:verbose] = true
  end

  # Another flag
  opts.on('-d', '--debug', 'Enable debug mode') do
    options[:debug] = true
  end

  # Flag with negation pattern
  opts.on('-q', '--[no-]quiet', 'Suppress output (default: false)') do |quiet|
    options[:quiet] = quiet
  end

  # Help is automatically handled, but we can customize
  opts.on('-h', '--help', 'Show this help message') do
    puts opts
    exit
  end
end.parse!

# Demonstrate the results
puts 'Options parsed:'
puts "  verbose: #{options[:verbose]}"
puts "  debug:   #{options[:debug]}"
puts "  quiet:   #{options[:quiet]}"
puts ''

# Show how you might use these in practice
puts '[VERBOSE] Starting application...' if options[:verbose]

puts '[DEBUG] Debug mode enabled - extra logging active' if options[:debug]

if options[:quiet]
  # In quiet mode, we'd suppress most output
  puts '[QUIET MODE: Minimal output]'
else
  puts 'Application running normally'
end

puts '[VERBOSE] Application complete' if options[:verbose]
