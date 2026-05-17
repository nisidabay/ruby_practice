#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_fibonacci.rb — recursion with overlapping subproblems
#
# WITHOUT recursion — iterative with a loop:
#
#   def fib(n)
#     a, b = 0, 1
#     (n-1).times { a, b = b, a + b }
#     b
#   end
#
# WITH recursion — each call spawns two more, tree-shaped:
#   fib(5) calls fib(4) + fib(3), each of those calls two more…

def fib(n)
  return n if n <= 1
  fib(n - 1) + fib(n - 2)
end

puts "fib(0) = #{fib(0)}"   # => 0
puts "fib(6) = #{fib(6)}"   # => 8
puts "fib(10) = #{fib(10)}" # => 55

# PROBLEM: fib(40) recomputes the same values millions of times.
# fib(4) gets computed 3 separate times in fib(6).
#
# This is why recursion isn't always the answer.
# See factorial.rb for linear recursion (one call per step).
# This tree-shaped recursion is why memoization exists.
