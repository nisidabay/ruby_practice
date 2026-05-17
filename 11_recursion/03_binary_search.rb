#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_binary_search.rb — recursion that cuts the problem in half each step
#
# WITHOUT recursion — loop with low/high pointers:
#
#   while low <= high; mid = (low+high)/2; ...; end
#   # works, but the recursive version reads closer to the algorithm definition
#
# WITH recursion — "search left half OR search right half":

def binary_search(arr, target, low = 0, high = arr.length - 1)
  return nil if low > high  # not found — base case

  mid = (low + high) / 2
  return mid if arr[mid] == target  # found — base case

  if target < arr[mid]
    binary_search(arr, target, low, mid - 1)    # search left
  else
    binary_search(arr, target, mid + 1, high)   # search right
  end
end

sorted = [2, 5, 8, 12, 16, 23, 38, 45, 56, 72]
puts "Index of 23: #{binary_search(sorted, 23)}"  # => 5
puts "Index of 99: #{binary_search(sorted, 99).inspect}"  # => nil

# O(log n) — each step halves the search space.
# A million elements takes ~20 steps.
# Recursion here is natural because the problem structure IS recursive.
