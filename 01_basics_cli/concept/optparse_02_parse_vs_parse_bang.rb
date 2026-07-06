#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_parse_vs_parse_bang.rb — Why .parse! and what happens to ARGV
#
# You typed .parse! in 01_basic_flags. Here's what it actually does.
#
#   ruby optparse_02_parse_vs_parse_bang.rb

require "optparse"

# parse! — DESTRUCTIVE. Removes options from the array in-place.

argv = ["--verbose", "file1.txt", "file2.txt"]
puts "Before parse!: #{argv.inspect}"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options] [files...]"
  opts.on("-v", "--verbose", "Enable verbose") { options[:verbose] = true }
end.parse!(argv)

puts "After parse!:  #{argv.inspect}"      # ["file1.txt", "file2.txt"]
puts "Parsed:        #{options.inspect}"   # {:verbose => true}
puts

# parse — NON-DESTRUCTIVE. Returns remaining args, leaves original alone.

argv2 = ["--verbose", "data.csv", "out.json"]
puts "Before parse: #{argv2.inspect}"

options2 = {}
remaining = OptionParser.new do |opts|
  opts.on("-v", "--verbose") { options2[:verbose] = true }
end.parse(argv2)

puts "After parse:  #{argv2.inspect}"     # unchanged
puts "Remaining:    #{remaining.inspect}"  # ["data.csv", "out.json"]
puts "Parsed:       #{options2.inspect}"
puts
puts "parse! => mutates the array, use with ARGV."
puts "parse  => returns remaining, use when you need original intact."

# Thinking in Ruby
#
# Ruby's ! (bang) convention signals destructiveness: parse! mutates ARGV,
# parse does not. This naming pattern — bang for side effects — is
# consistent across the entire standard library. Once you know the
# convention, you know what every bang method does without reading docs.
