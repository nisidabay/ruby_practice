#!/usr/bin/env ruby
# frozen_string_literal: true

# arrays.rb — Array reference

# Creation
a = []                      # empty
a = Array.new(3)            # [nil, nil, nil]
a = Array.new(3, 'x')       # ["x", "x", "x"]
a = Array.new(3) { |i| i**2 } # [0, 1, 4]
a = [1, 2, 3, 4, 5]        # literal
a = Array(0..4)             # [0, 1, 2, 3, 4] from range

# Access
p [10,20,30].at(1)          # => 20
p [10,20,30,40,50].values_at(0, 2, 4)  # => [10, 30, 50]
p [10,20,30].slice(1, 2)    # => [20, 30]
p [[1,2],[3,[4,5]]].dig(1, 1, 0)       # => 4
p [1,2,3,4,5].first(3)      # => [1, 2, 3]
p [1,2,3,4,5].last(2)       # => [4, 5]

# Add/Remove
a = [1, 2, 3]
a << 4                       # [1, 2, 3, 4]
a.push(5)                    # [1, 2, 3, 4, 5]
p a.pop                      # => 5
a.unshift(0)                 # [0, 1, 2, 3, 4]
p a.shift                    # => 0
a.insert(1, 'x')             # [1, 'x', 2, 3, 4]
a.delete('x')                # [1, 2, 3, 4]
a.delete_if { |e| e.even? }  # [1, 3]

# Iteration
[1, 2, 3].each { |e| puts e }
(1..4).each_slice(2) { |s| p s }  # [1,2] then [3,4]
(1..3).each_cons(2) { |s| p s }   # [1,2] then [2,3]

# Transformation
p [1, 2, 3].map { |e| e * 2 }     # => [2, 4, 6]
p [1, 2, 3].select(&:even?)       # => [2]
p [1, 2, 3].reject(&:even?)       # => [1, 3]

# Search
p [1..10].find { |n| n > 5 }      # => 6
p [1,3,5,7].bsearch { |n| n >= 5 } # => 5

# Flatten, Compact, Uniq
p [1, [2, [3]]].flatten           # => [1, 2, 3]
p [1, nil, 2].compact             # => [1, 2]
p [1, 2, 2, 3].uniq               # => [1, 2, 3]

# Set-like ops
a, b = [1, 2, 3], [3, 4, 5]
p a + b             # => [1, 2, 3, 3, 4, 5] (concat)
p a - b             # => [1, 2] (difference)
p a.intersection(b) # => [3]
p a.union(b)        # => [1, 2, 3, 4, 5]

# Count & Check
p [1, 2, 3].count               # => 3
p [1, 2, 2].count(2)            # => 2
p [1, 2, 3].count(&:even?)      # => 1
p [].empty?                      # => true
p [1, 2, 3].include?(2)         # => true

# Sorting
p [3, 1, 2].sort                 # => [1, 2, 3]
p %w[pear apple].sort_by(&:length) # => ["pear", "apple"]

# Min/Max/Sum
p [5, 2, 8, 1].min               # => 1
p [5, 2, 8, 1].max               # => 8
p [5, 2, 8, 1].minmax            # => [1, 8]
p [1, 2, 3].sum                  # => 6

# Combo & Perm & Zip & Transpose
p [1, 2, 3].combination(2).to_a  # => [[1,2],[1,3],[2,3]]
p [1, 2, 3].permutation(2).to_a  # => all ordered pairs
p %w[a b].zip([1, 2])            # => [["a",1],["b",2]]
p [[1,2],[3,4],[5,6]].transpose  # => [[1,3,5],[2,4,6]]

# Sampling & Shuffling
p [1, 2, 3].sample               # random element
p [1, 2, 3].shuffle              # random order
p [1, 2, 3].rotate(1)            # => [2, 3, 1]
p [1, 2, 3].reverse              # => [3, 2, 1]

# Fill
p [0,0,0,0,0].fill(7)            # => [7, 7, 7, 7, 7]
p [0,0,0,0,0].fill(9, 2, 2)      # => [0, 0, 9, 9, 0]

# Chunk
data = [1,1,2,2,1,1]
data.chunk { |n| n }.each { |val, items| p [val, items] }
