#!/usr/bin/env ruby
# frozen_string_literal: true

# Slice
# This file contains Ruby code for slice.

# Array slicing in Ruby returns a portion of an array using range indices

numbers = [10, 20, 30, 40, 50, 60, 70, 80]

# Using range to get a subset
puts numbers[2..5].inspect    # [30, 40, 50, 60] - inclusive range
puts numbers[2...5].inspect   # [30, 40, 50]    - exclusive range (excludes last)

# From start to index
puts numbers[0..2].inspect # [10, 20, 30]

# From index to end
puts numbers[5..-1].inspect # [60, 70, 80] - -1 means last element

# Negative ranges
puts numbers[-4..-1].inspect # [50, 60, 70, 80]

# Using begin and length
puts numbers.slice(2, 3).inspect # [30, 40, 50] - start at index 2, length 3

# Edge cases
puts numbers[10..15].inspect  # nil - out of bounds returns nil
puts numbers[5..2].inspect    # [] - return empty array

# Negative length returns nil
puts numbers.slice(2, -1).inspect
