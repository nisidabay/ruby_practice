#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Fill in the blanks for 02_strings_regex

require 'optparse'

options = { verbose: false }
parser = OptionParser.new do |opts|
  opts.on("-v", "--verbose", "Verbose mode") { options[:verbose] = true }
end.parse!

puts "=== Exercise 1: Basic ==="
# --- your code here ---

puts "
=== Exercise 2: Intermediate ==="
# --- your code here ---

puts "
=== Exercise 3: Advanced ==="
# --- your code here ---

puts "\n=== Exercise 4: XOR Cipher ==="
# Encrypt "hello" with password "key" using XOR, then decrypt it back.
# HINT: "hello".unpack("U*")          → [104, 101, 108, 108, 111]
# HINT: "key".unpack("U*")            → [107, 101, 121]
# HINT: [104,101].zip([107,101]).map { |a,b| a ^ b } → [3, 0]
# HINT: [3, 0].pack("U*")             → "\u0003\u0000"
# --- your code here ---
