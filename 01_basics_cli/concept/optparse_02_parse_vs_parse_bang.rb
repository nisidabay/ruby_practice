#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_parse_vs_parse_bang.rb — Why .parse! and what happens to ARGV
#
# You typed .parse! in 01_basic_flags. Here's what it actually does.
#
#   ruby optparse_02_parse_vs_parse_bang.rb

require "optparse"

program = File.basename($0, ".rb")

# ═══════════════════════════════════════════
# parse! — DESTRUCTIVE. Removes options from the array in-place.
# ═══════════════════════════════════════════

argv = ["--verbose", "file1.txt", "file2.txt"]
puts "Before parse!: #{argv.inspect}"

opts = {}
OptionParser.new do |o|
  o.banner = "Usage: #{program} [options] [files...]"
  o.on("-v", "--verbose", "Enable verbose") { opts[:verbose] = true }
end.parse!(argv)

puts "After parse!:  #{argv.inspect}"      # ["file1.txt", "file2.txt"]
puts "Parsed:        #{opts.inspect}"      # {:verbose => true}
puts

# ═══════════════════════════════════════════
# parse — NON-DESTRUCTIVE. Returns remaining args, leaves original alone.
# ═══════════════════════════════════════════

argv2 = ["--verbose", "data.csv", "out.json"]
puts "Before parse: #{argv2.inspect}"

opts2 = {}
remaining = OptionParser.new do |o|
  o.on("-v", "--verbose") { opts2[:verbose] = true }
end.parse(argv2)

puts "After parse:  #{argv2.inspect}"     # unchanged
puts "Remaining:    #{remaining.inspect}"  # ["data.csv", "out.json"]
puts "Parsed:       #{opts2.inspect}"
puts
puts "parse! => mutates the array, use with ARGV."
puts "parse  => returns remaining, use when you need original intact."
