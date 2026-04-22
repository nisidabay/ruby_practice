#!/usr/bin/env ruby
# frozen_string_literal: true
# Iteration with loops
# Array Operations
# This file demonstrates various array operations and methods.
# Shows enumeration, transformation, and filtering operations.

animals = %w[Leon Zebra Cheetah Baboon]

i = 0
while i < animals.length
  p "animal at index #{i} is: #{animals[i]}"
  i += 1
end

puts

x = 0
until x == animals.length
  p animals[x]
  x += 1
end
