#!/usr/bin/env ruby
# frozen_string_literal: true

# Array Operations
# This file demonstrates various array operations and methods.
# Shows enumeration, transformation, and filtering operations.

# Array.new creates a new array in Ruby
# Can be called with no arguments, with a size, or with a size and default
# value

# Empty array
empty = []
puts empty # []

# Array with specified size (contains nil values)
array_of_five = Array.new(5)
puts array_of_five # [nil, nil, nil, nil, nil]
puts array_of_five.length # 5

# Array with size and default value
zeros = Array.new(4, 0)
puts zeros # [0, 0, 0, 0]

# Creating array with block (each element is result of block)
squares = Array.new(4) { |i| i * i }
puts squares # [0, 1, 4, 9]

# Assign values
ages = Array.new(4)
ages[0] = 49
ages[1] = 48
ages[2] = 17
ages[3] = 14

puts ages # [49, 48, 17, 14]

# Can also add elements after creation
ages << 6
puts ages # [49, 48, 17, 14, 6]

# Using with a string (careful - same object reference!)
# This would create the same string instance 3 times:
# strings = Array.new(3, "hello")  # All elements point to same string
# Better to use block for unique objects:
unique_strings = Array.new(3) { 'hello' }
puts unique_strings
