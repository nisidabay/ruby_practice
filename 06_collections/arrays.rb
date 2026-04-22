#!/usr/bin/env ruby
# frozen_string_literal: true
# Array Operations
# This file demonstrates various array operations and methods.
# Shows enumeration, transformation, and filtering operations.


# Ruby Array Operations

# Create an empty array
empty_array = []
puts "Empty array: #{empty_array.inspect}"

# Create an array with a specified size (filled with nil by default)
sized_array = Array.new(20)
puts "Array with size 20: #{sized_array.inspect}"

# Get the size of the array
puts "Size of the array: #{sized_array.size}"
puts "Length of the array: #{sized_array.length}"

# Assign a default value to all elements during creation
default_array = Array.new(4, 'Nil')
puts "Array with default 'Nil' values: #{default_array.inspect}"

# Assign values to an array using a block (indices raised to the power of 2)
squared_array = Array.new(10) { |index| index**2 }
puts "Array with squares of indices: #{squared_array.inspect}"

# Create an array using a literal
number_array = [1, 2, 3, 4, 5]
puts "Array using a literal: #{number_array.inspect}"

# Create an array from a range
range_array = Array(0..9)
puts "Array from range 0..9: #{range_array.inspect}"

# Access elements by index
sample_array = Array(0..11)
puts "Array from range 0..11: #{sample_array.inspect}"
puts "Element at index 2: #{sample_array.at(2)}" # Safely access element at index 2
puts "Element at index 3: #{sample_array.at(3)}" # Safely access element at index 3

# Array modification examples
mutable_array = sample_array.dup
mutable_array << 'word'
puts "Array after adding 'word': #{mutable_array.inspect}"

mutable_array.push('letter')
puts "Array after pushing 'letter': #{mutable_array.inspect}"

puts "Popped element: #{mutable_array.pop}"

# String operations with arrays
names = %w[carlos alicia sergio clara dani]
puts "Joined names: #{names.join('-')}"

# String splitting examples
puts "Splitting on non-word characters: #{'This is a test'.split(/\W+/).inspect}"

puts "Splitting on periods: #{'Short sentence. Another. No more.'.split('.').inspect}"

puts "Splitting on spaces: #{'Words with lots of spaces'.split(/\s+/).inspect}"

# Array iteration examples
test_array = [1, 'test', 2, 3, 4]
test_array.each { |element| puts "Element: #{element}" }

# Array transformation examples (map and collect are aliases)
# This methods are the same
numbers = [1, 2, 3]
puts "Doubled elements: #{numbers.map { |element| element * 2 }.inspect}"
puts "Triple elements: #{numbers.collect { |element| element * 3 }.inspect}"

# Create and iterate over an array with initialized values
numbers = Array.new(10) { |index| index * 2 }
numbers.each do |number|
  puts "Number: #{number}"
end

# Array concatenation
x = [1, 2, 3]
y = %w[a b c]
z = x + y
p z

# Array subtraction and difference
x = [1, 2, 3, 4, 5]
y = [1, 2, 3]
z = x - y
p z

# Checking for an empty array
w = []
p 'w is empty' if w.empty?

# Checking an array for a certain item
x = [1, 3, 4]
p x.include?('x')
p x.include?(3)

# Array filtering with select (returns elements that match condition)
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p "Even numbers: #{numbers.select(&:even?).inspect}"
p "Odd numbers: #{numbers.reject(&:even?).inspect}"

# Find first element matching condition
p "First number > 5: #{numbers.find { |n| n > 5 }}"
