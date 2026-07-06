#!/usr/bin/env ruby
# frozen_string_literal: true

# enumerable.rb — Enumerable module reference (works on Array, Hash, Range, Set)

p Array.include?(Enumerable)   # => true
p Hash.include?(Enumerable)    # => true
p Range.include?(Enumerable)   # => true

nums = [10, 20, 30, 40, 50]
words = %w[hello world ruby programming]

# Iteration
nums.each { |n| puts n }
nums.each_with_index { |n, i| puts "#{i}: #{n}" }
nums.reverse_each { |n| puts n }
[1, 2, 3].cycle(2) { |n| puts n }
(1..9).each_slice(3) { |s| p s }          # [1,2,3] then [4,5,6] then [7,8,9]
(1..5).each_cons(3) { |c| p c }           # [1,2,3], [2,3,4], [3,4,5]

# Transformation
p nums.map { |n| n * 2 }                  # => [20, 40, 60, 80, 100]
p %w[hi there].flat_map(&:chars)          # => ["h", "i", "t", "h", "e", "r", "e"]

# Filtering
p nums.select(&:even?)                     # => [10, 20, 30, 40, 50]
p nums.reject(&:even?)                     # => []
p nums.find { |n| n > 25 }                # => 30
p nums.first(3)                            # => [10, 20, 30]
p nums.drop(2)                             # => [30, 40, 50]
p nums.take(3)                             # => [10, 20, 30]
p (1..10).take_while { |n| n < 5 }        # => [1, 2, 3, 4]
p (1..10).drop_while { |n| n < 5 }        # => [5, 6, 7, 8, 9, 10]
p [1, 2, 3, 4].filter_map { |n| n * 2 if n.even? }  # => [4, 8]

# Partition & Group
evens, odds = (1..10).partition(&:even?)
p evens   # => [2, 4, 6, 8, 10]
p odds    # => [1, 3, 5, 7, 9]

fruits = %w[apple banana apple orange banana apple]
p fruits.tally  # => {"apple"=>3, "banana"=>2, "orange"=>1}

# Grep
mixed = [1, 'two', 3, 'four', :six]
p mixed.grep(Integer)     # => [1, 3]
p mixed.grep(String)      # => ["two", "four"]
p words.grep(/^r/)        # => ["ruby"]

# Aggregation
p nums.reduce(0) { |sum, n| sum + n }   # => 150
p nums.reduce(:+)                        # => 150
p nums.sum                               # => 150
p nums.count                             # => 5
p nums.count(&:even?)                    # => 5

# Boolean checks
p nums.any?(&:even?)                     # => true
p nums.all?(&:even?)                     # => true
p nums.none?(&:negative?)                # => true
p nums.one? { |n| n == 30 }             # => true
p nums.include?(20)                      # => true

# Min/Max
p nums.min                             # => 10
p nums.max                             # => 50
p nums.minmax                          # => [10, 50]
p words.min_by(&:length)               # => "ruby"
p words.max_by(&:length)               # => "programming"

# Sort
p [3, 1, 4].sort                       # => [1, 3, 4]
p words.sort_by(&:length)              # => ["ruby", "hello", "world", "programming"]

# Zip
p %w[a b].zip([1, 2], [10, 20])        # => [["a",1,10],["b",2,20]]

# Chunking
data = [1, 1, 2, 2, 1, 1]
data.chunk { |n| n }.each { |k, v| p [k, v] }
[1, 2, 10, 11, 20].chunk_while { |a, b| a + 1 == b }.each { |r| p r }
[1, 2, 3, 1].slice_before(&:odd?).each { |s| p s }
[1, 2, 3, 4].slice_after { |n| n % 2 == 0 }.each { |s| p s }

# Lazy (for infinite ranges)
p (1..Float::INFINITY).lazy.select(&:even?).map { |n| n**2 }.first(3)  # => [4, 16, 36]

# Thinking in Ruby
#
# Enumerable is Ruby's superpower — implement each, include Enumerable,
# and get 50+ methods free (map, select, reduce, sort, group_by, chunk,
# tally, grep, lazy, and more). All major collections (Array, Hash,
# Range, Set) work this way. This is Ruby's approach to the Iterator
# pattern at the language level.
