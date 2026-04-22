#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Factorial Calculator
# This file calculates the factorial of a given number using recursion.
# Demonstrates recursive function calls and accumulator patterns.

# Factorial using a loop. No stack limits

def factorial_iterative(number)
  return 1 if number <= 1

  result = 1
  (2..number).each do |n|
    result *= n
  end
  result
end

puts factorial_iterative(5)
