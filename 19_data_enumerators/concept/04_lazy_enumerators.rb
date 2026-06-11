#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Process a huge dataset without building intermediate arrays.
# Example: Take the first 5 even squares from 1 to 1,000,000 — without creating a million-element array.
#
# Solution: .lazy — creates a lazy enumerator. No intermediate arrays.
# Visibility: Chain .select, .map, .reject lazily, then .take or .force at the end.

# EAGER (creates intermediate arrays — memory explosion):
# (1..1_000_000).select(&:even?).map { |n| n * n }.take(5)  # builds huge arrays!

# LAZY (no intermediate arrays — constant memory):
result = (1..1_000_000).lazy.select(&:even?).map { |n| n * n }.take(5).force
puts "First 5 even squares: #{result}"  # => [4, 16, 36, 64, 100]

# Usage: Infinite lazy stream
infinite = (1..).lazy.select(&:even?).map { |n| n * n }
puts infinite.take(5).force  # => [4, 16, 36, 64, 100]

# Usage: Lazy file processing — read huge file line by line
# File.foreach('huge.log').lazy.select { |l| l.include?('ERROR') }.take(10).force

# This could also be done like this:
# Manual loop with break (works but less composable):
#
#   count = 0
#   (1..1_000_000).each do |n|
#     next unless n.even?
#     puts n * n
#     count += 1
#     break if count >= 5
#   end
#
# .lazy is more declarative — "select evens, map to squares, take 5."
