#!/usr/bin/env ruby
# Blocks
# This file contains Ruby code for blocks.

# frozen_string_literal: true
#!/usr/bin/ruby
#
# Use of blocks with the times method

# Execute a single line
3.times { puts "I'm learning ruby basics" }

# Execute multiple lines
5.times do
  puts 'Looks easy'
  puts 'I wish it is'
end

10.times do |num|
  puts "We are currently on loop number #{num}"
end

puts 'The same thing'
10.times { |num| puts "We are currently on loop number #{num}" }

10.times do |num|
  puts "#{3 * (num + 1)}"
end

10.times { |num| puts "#{3 * (num + 1)}" }

def hello_five_times
  5.times { puts 'Hello' }
end

def money_printer(value)
  value.times { puts 'Money' }
end

hello_five_times
money_printer(3)
money_printer(5)
money_printer(0)
