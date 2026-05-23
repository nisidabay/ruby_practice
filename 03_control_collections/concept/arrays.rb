#!/usr/bin/env ruby
# frozen_string_literal: true

# arrays.rb — REFERENCE: quick lookup, not a concept file
# See 10_arrays/ for individual method AHAs (fetch, include, etc.)

# Creation
a = [1, 2, 3, 4, 5]                  # literal
a = Array.new(3, 0)                   # => [0, 0, 0]
a = Array(1..3)                       # => [1, 2, 3]

# Add / Remove
a = [1, 2]
a << 3                                # => [1, 2, 3]
a.push(4)                             # => [1, 2, 3, 4]
a.pop                                 # => 4 (removes last)
a.unshift(0)                          # => [0, 1, 2, 3]
a.shift                               # => 0 (removes first)
a.delete(2)                           # => [1, 3]

# Transformation (non-destructive)
p [1, 2, 3].map { |n| n * 2 }        # => [2, 4, 6]
p [1, 2, 3].select(&:even?)           # => [2]
p [1, 2, 3].reject(&:even?)           # => [1, 3]

# Flatten / Uniq / Compact
p [1, [2, [3]]].flatten               # => [1, 2, 3]
p [1, 2, 2, 3].uniq                   # => [1, 2, 3]
p [1, nil, 2].compact                 # => [1, 2]

# Set-like
a, b = [1, 2], [2, 3]
p a & b                               # => [2]  (intersection)
p a | b                               # => [1, 2, 3]  (union)
p a - b                               # => [1]  (difference)

# Query
p [1, 2, 3].count                     # => 3
p [1, 2, 2].count(2)                  # => 2
p [].empty?                           # => true

# Sort / Min / Max / Sum
p [3, 1, 2].sort                      # => [1, 2, 3]
p [1, 2, 3].sum                       # => 6
p [5, 2, 8].minmax                    # => [2, 8]

# Iteration helpers
(1..3).each_slice(2) { |s| p s }      # => [1,2] then [3]
(1..3).each_cons(2) { |s| p s }       # => [1,2] then [2,3]
