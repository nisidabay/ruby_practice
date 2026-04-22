#!/usr/bin/env ruby
# frozen_string_literal: true

# Factorial Calculator
# This file calculates the factorial of a given number using recursion.
# Demonstrates recursive function calls and accumulator patterns.

# This script calculates the factorial of a given number using recursion.

# Calculates the factorial of a number.
# @param num [Integer] the number to calculate the factorial for
# @param acc [Integer] the accumulator to hold the intermediate product (default is 1)
# @return [Integer] the factorial of the number
def factorial(num, acc = 1)
  puts("acc: #{acc}")
  return acc if num <= 1
  return acc if num == 0

  factorial(num - 1, acc * num)
end

# Main execution starts here
puts 'Enter a number:'
num = gets&.chomp&.to_i || 5
fac = factorial(num)
puts "The factorial of #{num} is #{fac}."
