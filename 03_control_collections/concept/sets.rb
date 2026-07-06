#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

# sets.rb — Set reference (unordered, unique elements)

# Creation
s = Set.new
s = Set.new([1, 2, 3, 4, 5])
s = Set['a', 'b', 'c']
s = Set.new(1..5)

# Add/Remove
s = Set.new([1, 2])
s.add(3)                # returns self
s.add(2)                # duplicate, ignored
s.add?(4)               # returns self (added)
s.add?(4)               # returns nil (already there)
s.delete(1)
s.delete_if(&:even?)

# Query
p s.size               # => count
p s.empty?             # => false
p s.include?(3)        # => true

# Set operations
a = Set[1, 2, 3, 4]
b = Set[3, 4, 5, 6]
p a | b                # union => #{1,2,3,4,5,6}
p a & b                # intersection => #{3,4}
p a - b                # difference => #{1,2}
p a ^ b                # symmetric difference => #{1,2,5,6}

# Subset/Superset
small = Set[1, 2]
big = Set[1, 2, 3, 4, 5]
p small.subset?(big)          # => true
p small.proper_subset?(big)   # => true
p big.superset?(small)        # => true
p small <= big        # => true (subset operator)

# Disjoint
p Set[1, 2].disjoint?(Set[3, 4])  # => true
p a.intersect?(b)                 # => true (opposite of disjoint?)

# Equality (order doesn't matter)
p Set[1, 2, 3] == Set[3, 2, 1]  # => true

# Iteration & Transformation
Set[1, 2, 3].each { |e| puts e }
p Set[1, 2, 3].map { |n| n * 2 }  # => [2, 4, 6] (returns Array)
p Set.new(1..10).select(&:even?)  # => Set of evens

# Conversion
p s.to_a
p s.sort  # returns sorted array
#
# Thinking in Ruby
#
# Ruby includes Set as a standard library class, not a built-in type,
# because its Hash-based implementation naturally fits the duck-typing
# philosophy — Set is literally "a Hash where values are ignored."
# The overlap with Array methods (map, select, each) is intentional:
# in Ruby, collection types share a common Enumerable interface,
# so you think in terms of operations, not data structures.
