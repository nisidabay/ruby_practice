#!/usr/bin/env ruby
# frozen_string_literal: true

# loop_do.rb — infinite loop with break

loop do
  print "Enter the magic word to 'exit' the loop: "
  input = gets&.chomp
  break if input.nil? || input.include?('exit')

  puts "You're still trapped"
end

puts 'Leaving loop'

# Thinking in Ruby
#
# loop do...end creates an infinite loop — the simplest possible
# iteration primitive. Combined with explicit break/return, it's Ruby's
# answer to "loop until something happens" patterns (user input, server
# accept loops). The verbosity is intentional: infinite loops are
# important enough to deserve their own keyword.
