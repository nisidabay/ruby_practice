#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_basic_flags.rb — Boolean flags: the simplest OptionParser entry point
#
#   ruby optparse_01_basic_flags.rb -v
#   ruby optparse_01_basic_flags.rb --verbose --debug
#   ruby optparse_01_basic_flags.rb --no-quiet
#   ruby optparse_01_basic_flags.rb -h

require "optparse"

options = { verbose: false, debug: false, quiet: false }

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  opts.on("-v", "--verbose", "Enable verbose output") do
    options[:verbose] = true
  end

  opts.on("-d", "--debug", "Enable debug mode") do
    options[:debug] = true
  end

  # --[no-]quiet creates TWO flags: --quiet (sets true) and --no-quiet (sets false)
  opts.on("-q", "--[no-]quiet", "Suppress output") do |q|
    options[:quiet] = q
  end

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end
end.parse!

puts "verbose: #{options[:verbose]}"
puts "debug:   #{options[:debug]}"
puts "quiet:   #{options[:quiet]}"
