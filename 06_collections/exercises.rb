#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Arrays, hashes, ranges, enumerable

# --- Array: sort these names alphabetically ---
names = ["Carlos", "Ana", "Beatriz", "David"]
sorted = nil  # <-- replace nil with your code
puts sorted.inspect  # Expected: ["Ana", "Beatriz", "Carlos", "David"]

# --- Hash: create a phone book with 3 entries, then look one up ---
phone_book = {}  # <-- fill me
puts phone_book["Carlos"]

# --- Range: sum all numbers from 1 to 100 ---
# Hint: (1..100).sum or (1..100).reduce(:+)
sum = nil
puts "Sum 1..100 = #{sum}"  # Expected: 5050

# --- Enumerable: select only even numbers from an array ---
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
evens = nil
puts evens.inspect  # Expected: [2, 4, 6, 8, 10]

# --- BONUS: group words by their first letter ---
# Hint: group_by { |w| w[0] }
words = ["apple", "banana", "avocado", "cherry", "apricot", "blueberry"]
