#!/usr/bin/env ruby
# frozen_string_literal: true

# blocks.rb — using blocks with times

3.times { puts "I'm learning ruby basics" }

5.times do
  puts 'Looks easy'
  puts 'I wish it is'
end

10.times { |num| puts "We are currently on loop number #{num}" }

def hello_five_times
  5.times { puts 'Hello' }
end
hello_five_times

def money_printer(value)
  value.times { puts 'Money' }
end
money_printer(3)

# Thinking in Ruby
#
# Blocks with {} (single-line) and do...end (multi-line) are Ruby's
# fundamental iteration construct. The times method accepts a block that
# runs N times, with an optional block parameter for the current count.
# Blocks are closures — they capture the surrounding scope — making them
# more powerful than simple loop counters.
