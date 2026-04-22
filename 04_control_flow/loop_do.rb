#!/usr/bin/env ruby
# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including classes and modules.
# Shows inheritance, polymorphism, and encapsulation.

# frozen_string_literal: true

# !/usr/bin/ruby

loop do
  print "Enter the magic word to 'exit' the loop: "
  input = gets&.chomp
  break if input.nil?

  if input.include?('exit')
    puts "You entered the magic word: #{input}"
    puts 'Leaving loop'
    break
  else
    puts "You're still trapped"
  end
end
