#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including classes and modules.
# Shows inheritance, polymorphism, and encapsulation.

# Looping thru numbers

5.times { puts 'Test' }
puts

1.upto(5) { |number| puts number }
puts

10.downto(5) { |number| puts number }
puts

0.step(50, 5) { |number| puts number }
puts
#
# You can spread the code multiple lines
1.upto(5) do |number|
  puts number
end

99.downto(1) do |number|
  puts "#{number} bottles of beer on the wall, #{number} bottles of beer"
  puts 'Take one down, pass it around'
  puts "#{number - 1} bottles of beer on the wall"
end
