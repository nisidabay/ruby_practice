#!/usr/bin/env ruby
# frozen_string_literal: true

# factorial.rb — recursion: a function that calls itself

# WITHOUT recursion — manage state with a loop:
#
#   def factorial(n)
#     result = 1
#     (2..n).each { |i| result *= i }
#     result
#   end
#   # Works, but some problems (tree traversal, nested data)
#   # are awkward when you have to track state manually.
#
# WITH recursion — the function calls itself with n-1
# until it hits the base case (n <= 1):

def factorial(n)
  return 1 if n <= 1
  n * factorial(n - 1)
end

puts factorial(5)  # => 120 (5 * 4 * 3 * 2 * 1)
puts factorial(0)  # => 1   (base case)
