#!/usr/bin/env ruby
# frozen_string_literal: true

# Indexing
# This file contains Ruby code for indexing.

# Array Indexing in Ruby
# Arrays are zero-indexed, meaning the first element is at index 0

fruits = %w[apple banana cherry date elderberry]

# Accessing elements by index
puts fruits[0]    # "apple"
puts fruits[1]    # "banana"
puts fruits[2]    # "cherry"

# Negative indexing (starts from the end)
puts fruits[-1]   # "elderberry"
puts fruits[-2]   # "date"

# Accessing out of bounds returns nil
puts fruits[10]   # nil
puts fruits[-10]  # nil

# Assigning values by index: apple is replaced
fruits[0] = 'avocado'
puts fruits[0] # "avocado"

# Adding new elements at specific indices
fruits[5] = 'fig'
puts fruits # ["avocado", "banana", "cherry", "date", "elderberry", "fig"]

# Using parentheses in string interpolation
years = [2014, 2015, 2016]
puts "Year 1: #{years[0]}"
puts "Year 2: #{years[1]}"
puts "Year 3: #{years[2]}"
puts "Year 4: #{years[3]}" # nil
puts "Year 100: #{years[99]}" # nil

# Thinking in Ruby
#
# Ruby arrays support positive indexing (from start), negative indexing
# (from end), and out-of-bounds access returning nil — not an exception.
# This nil-returning contract is intentional: you guard with || or fetch
# when you need safety, but the common case stays simple. Negative
# indices are a Ruby original that C-style languages later adopted.
