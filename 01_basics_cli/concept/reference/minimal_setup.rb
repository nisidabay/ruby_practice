#!/usr/bin/env ruby

require 'optparse'

# Dynamic script name - works regardless of how script is invoked
program = File.basename($0, '.rb')

options = { verbose: false }

OptionParser.new do |opts|
  opts.banner = <<~BANNER
    Usage: #{program} [options]

    Minimal OptionParser setup with dynamic script name.

    Options:
  BANNER

  opts.on('-v', '--verbose', 'Turn on verbose mode') do
    options[:verbose] = true
    puts 'Verbose mode is on!'
  end

  opts.on('-h', '--help', 'Show this help message') do
    puts opts
    exit
  end
end.parse!

puts "Options: #{options.inspect}"
puts "Remaining ARGV: #{ARGV.inspect}"
