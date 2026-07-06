#!/usr/bin/env ruby
# frozen_string_literal: true

# ranges.rb — Range reference

# Creation
r = 1..10        # inclusive
r = 1...10       # exclusive (excludes end)
r = 'a'..'e'     # string ranges
r = Range.new(1, 10)
r = Range.new(1, 10, true)  # exclusive

# Query
p (1..10).begin        # => 1
p (1..10).first        # => 1
p (1..10).end          # => 10
p (1..10).last         # => 10
p (1..10).size         # => 10
p (1...10).exclude_end?  # => true
p (1..10).last(3)      # => [8, 9, 10]

# Membership
p ('a'..'z').include?('f')    # => true (iterates through sequence)
p ('a'..'z').cover?('f')      # => true (bounds check)
p ('a'..'z').cover?('aa')     # => true (between bounds)
p ('a'..'z').include?('aa')   # => false (not in sequence)
p (1..5).overlap?(3..7)       # => true

# Iteration
(1..5).each { |n| puts n }
(1..10).step(2) { |n| puts n }
(1..5).reverse_each { |n| puts n }

# Conversion
p (1..5).to_a          # => [1, 2, 3, 4, 5]

# Enumerable methods work on ranges
p (1..5).select(&:even?)    # => [2, 4]
p (1..5).map { |n| n * 2 }  # => [2, 4, 6, 8, 10]
p (1..5).reduce(:+)         # => 15
p (1..5).any? { |n| n > 3 } # => true
p (1..100).bsearch { |n| n >= 42 } # => 42

# Thinking in Ruby
#
# Ranges implement include? (iterates the sequence) vs cover? (bounds
# check) — a performance distinction most languages ignore. cover? is
# O(1) while include? on non-integer ranges requires iteration. Ruby
# gives you both because it trusts you to know which you need.
