#!/usr/bin/env ruby
# frozen_string_literal: true

# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including classes and modules.
# Shows inheritance, polymorphism, and encapsulation.

# For Loops in Ruby

# Basic for loop with a range
puts 'Basic for loop with range:'
for i in 1..5
  puts "Iteration #{i}"
end

puts "\n" # Add a blank line for readability

# For loop with an array
puts 'For loop with an array:'
fruits = %w[apple banana cherry]
for fruit in fruits
  puts "I like #{fruit}"
end

puts "\n"

# For loop with exclusive range
puts 'For loop with exclusive range (1...5 excludes 5):'
for i in 1...5
  puts "Number: #{i}"
end

puts "\n"

# For loop with a hash
puts 'For loop with a hash:'
person = { name: 'John', age: 30, city: 'New York' }
for key, value in person
  puts "#{key}: #{value}"
end

puts "\n"

# For loop with characters in a string - must use each_char
puts 'For loop with characters in a string:'
for char in 'Hello'.chars
  puts "Character: #{char}"
end

puts "\n"

# Nested for loops
puts 'Nested for loops:'
for i in 1..3
  for j in 1..3
    puts "#{i} x #{j} = #{i * j}"
  end
  puts '---' # Separator
end

puts "\n"

# The Ruby Way - Using each instead of for loops
puts 'THE RUBY WAY - Using each:'

puts "\nRange with each:"
(1..5).each do |i|
  puts "Iteration #{i}"
end

puts "\nArray with each:"
fruits = %w[apple banana cherry]
fruits.each do |fruit|
  puts "I like #{fruit}"
end

puts "\nExclusive range with each:"
(1...5).each do |i|
  puts "Number: #{i}"
end

puts "\nHash with each:"
person = { name: 'John', age: 30, city: 'New York' }
person.each do |key, value|
  puts "#{key}: #{value}"
end

puts "\nString with each:"
'Hello'.each_char do |char|
  puts "Character: #{char}"
end

puts "\nNested each:"
(1..3).each do |i|
  (1..3).each do |j|
    puts "#{i} x #{j} = #{i * j}"
  end
  puts '---' # Separator
end
