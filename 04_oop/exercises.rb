#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Fill in the blanks for 04_oop

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
