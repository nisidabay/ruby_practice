#!/usr/bin/env ruby
# frozen_string_literal: true
# High-order-functions
# This file contains Ruby code for high-order-functions.


# High-order functions are functions that can take other functions as arguments
# or return them as result.

# Takes an array and a condition (a callable object) as arguments
def filter(array, condition)
  array.select { |element| condition.call(element) }
end

# A lambda to check if a number is even
even = lambda(&:even?)

numbers = [1, 2, 3, 4, 5, 6]
even_numbers = filter(numbers, even)
puts even_numbers.inspect

# Function that creates a multiplier lambda
def create_multiplier(factor)
  ->(x) { x * factor }
end

# Creating specific multiplier functions
double = create_multiplier(2)
triple = create_multiplier(3)

puts double.call(5)
puts triple.call(5)
