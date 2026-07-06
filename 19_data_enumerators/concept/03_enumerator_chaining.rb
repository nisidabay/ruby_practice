#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need index + value, or an accumulator, while iterating.
# Example: Number lines of a file, or group words by their first letter.
#
# Solution: Enumerator chaining — .with_index, .with_object, .each_with_object.
# Visibility: These are Enumerator methods — chain them after any enumerable.

words = %w[apple banana apricot blueberry avocado cherry]

# with_index — add an index to each element
words.each.with_index(1) do |word, i|
  puts "#{i}. #{word}"
end
# 1. apple, 2. banana, ...

# with_object — carry an accumulator through iteration
puts "\nGrouped by first letter:"
grouped = words.each.with_object(Hash.new { |h, k| h[k] = [] }) do |word, hash|
  hash[word[0]] << word
end
puts grouped  # => {"a"=>["apple","apricot","avocado"], "b"=>["banana","blueberry"], "c"=>["cherry"]}

# Usage: each_with_object — same but object comes first in block args
result = (1..5).each_with_object([]) { |n, arr| arr << n * n }
puts "Squares: #{result}"  # => [1, 4, 9, 16, 25]

# This could also be done like this:
# Manual accumulator (more lines):
#
#   grouped = {}
#   words.each do |word|
#     key = word[0]
#     grouped[key] ||= []
#     grouped[key] << word
#   end
#
# with_object is cleaner — no need to initialize and return the accumulator.
#
# Thinking in Ruby
#
# Enumerator chaining (with_index, with_object) is Ruby's solution to a common
# need: carrying state through iteration without external variables. Instead of
# declaring an accumulator outside the loop and mutating it inside, Ruby lets
# you carry state as part of the enumerator chain itself. This keeps iteration
# logic self-contained and avoids the "what mutated my variable?" problem that
# plagues manual accumulator patterns in many languages.
