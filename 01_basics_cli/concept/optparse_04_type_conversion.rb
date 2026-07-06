#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_type_conversion.rb — OptionParser auto-converts arguments to types
#
# In 03, the block got a String. Here, OptionParser does the conversion
# BEFORE the block runs: Integer, Float.
#
#   ruby optparse_04_type_conversion.rb -h

require 'optparse'

options = { concurrent_downloads: 3, rate_limit: 0.0, timeout: 30 }

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"
  opts.on('-c', '--concurrent-downloads N', Integer, 'Number of concurrent downloads (default: 3)') do |n|
    options[:concurrent_downloads] = n
  end

  opts.on('-r', '--rate-limit KBPS', Float, 'Rate limit in KB/s (default: unlimited)') do |r|
    options[:rate_limit] = r
  end

  opts.on('-t', '--timeout SECS', Integer, 'Timeout in seconds (default: 30)') do |t|
    options[:timeout] = t
  end

  opts.on('-h', '--help', 'Show this help') do
    puts opts
    exit
  end
end.parse!

puts "Concurrent:   #{options[:concurrent_downloads]}   (#{options[:concurrent_downloads].class})"
puts "Rate limit:   #{options[:rate_limit]}   (#{options[:rate_limit].class})"
puts "Timeout:      #{options[:timeout]}   (#{options[:timeout].class})"
puts

# These comparisons work because OptionParser already converted the types
puts "Rate limit > 0?     #{options[:rate_limit] > 0}"
puts "Timeout > 60?       #{options[:timeout] > 60}"
puts "Concurrent >= 2?    #{options[:concurrent_downloads] >= 2}"

# Thinking in Ruby
#
# OptionParser auto-converts arguments to Integer or Float before your
# block runs — catching type errors at parse time rather than deep in
# business logic. This reflects Ruby's philosophy: push validation to
# the boundary, keep domain code clean of parsing concerns.
