#!/usr/bin/env ruby
# frozen_string_literal: true

# map.rb — transform arrays element-by-element (collect is alias)

# Basic transformation
names = %w[Alice Bob Steve Alison]
p names.map(&:upcase)       # => ["ALICE", "BOB", "STEVE", "ALISON"]
p names.collect(&:downcase) # => ["alice", "bob", "steve", "alison"]

numbers = [1, 2, 3, 4, 5]
p numbers.map { |n| n * n }  # => [1, 4, 9, 16, 25]

# Extract fields from array of hashes
users = [{ name: 'Alice', age: 25 }, { name: 'Bob', age: 30 }]
p users.map { |u| u[:name] }  # => ["Alice", "Bob"]

# &: shorthand (Symbol-to-Proc)
p %w[apple banana cherry].map(&:upcase)  # => ["APPLE", "BANANA", "CHERRY"]
p [1, 2, 3].map(&:to_s)                 # => ["1", "2", "3"]
p [1, 2, 3, 4].map(&:odd?)              # => [true, false, true, false]

# Build hash from two arrays
keys = %i[a b c]; values = [1, 2, 3]
p keys.zip(values).to_h  # => {:a=>1, :b=>2, :c=>3}

# Range to array
p (1..5).map { |n| n**2 }  # => [1, 4, 9, 16, 25]

# Conditional transformation
nums = [1, 2, 3, 4, 5]
p nums.map { |n| n.even? ? 'even' : 'odd' }  # => ["odd", "even", ...]
p nums.map { |n| n > 3 ? n * 10 : n }        # => [1, 2, 3, 40, 50]

# Chaining
p %w[hello world ruby].map(&:upcase).select { |w| w.length > 4 }  # => ["HELLO", "WORLD"]

# Nested arrays
matrix = [[1, 2], [3, 4], [5, 6]]
p matrix.map { |row| row.map { |n| n * 2 } }  # => [[2, 4], [6, 8], [10, 12]]

