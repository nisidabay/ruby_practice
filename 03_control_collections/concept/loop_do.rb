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
