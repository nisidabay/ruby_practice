#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Algorithm warmups: FizzBuzz, palindrome, factorial

# --- FizzBuzz for 1..20 ---
# Print each number. If divisible by 3 → "Fizz", by 5 → "Buzz", both → "FizzBuzz"
# (1..20).each do |n|
#   # your code here
# end

# --- Is this string a palindrome? (same forward and backward) ---
def palindrome?(str)
  # your code here — hint: str == str.reverse
end
puts palindrome?("racecar") # => true
puts palindrome?("hello")   # => false

# --- Factorial: 5! = 5 * 4 * 3 * 2 * 1 = 120 ---
def factorial(n)
  # your code here — hint: (1..n).reduce(:*)
end
puts factorial(5)  # => 120
puts factorial(0)  # => 1 (by definition)

# --- Find the largest number in an array without using .max ---
def max_number(arr)
  # your code here
end
puts max_number([3, 7, 2, 9, 1])  # => 9
