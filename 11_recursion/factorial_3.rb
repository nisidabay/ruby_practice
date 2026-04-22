#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Factorial Calculator
# This file calculates the factorial of a given number using recursion.
# Demonstrates recursive function calls and accumulator patterns.

# Factorial Ruby way
def factorial_rubyist(num)
  return 1 if num <= 1

  (1..num).inject(:*)
end

puts factorial_rubyist(5)
