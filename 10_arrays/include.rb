#!/usr/bin/env ruby
# frozen_string_literal: true

# Include
# This file contains Ruby code for include.

# The include? method in Ruby checks if an array contains a specific value
# Returns true if the value is found, false otherwise

fruits = %w[apple banana cherry date]

# Check if array includes a value
puts fruits.include?('apple')     # true
puts fruits.include?('banana')    # true
puts fruits.include?('grape')     # false
puts fruits.include?('APPLE')     # false (case sensitive)

# Using include? in conditional statements
birth_year = 2014
years = [2014, 2015, 2016]

if years.include?(birth_year)
  puts "#{birth_year} is in the array"
else
  puts "#{birth_year} is not in the array"
end

# Works with any data types
numbers = [1, 2, 3, 4, 5]
puts numbers.include?(3)      # true
puts numbers.include?(10)     # false

mixed = [1, 'hello', true, nil]
puts mixed.include?(1)        # true
puts mixed.include?('hello')  # true
puts mixed.include?(nil)      # true
