#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to create a custom collection that works with
# map, select, find, reject, and other enumeration methods.
# Example: MyArray.new([1, 2, 3]).select { |x| x > 1 } should just work.
#
# Solution: Include Enumerable and implement #each.
# Result: Get 40+ methods for free!

class MyArray
  include Enumerable

  def initialize(arr)
    @array = arr
  end

  # Required: Implement #each to yield elements
  def each(&)
    @array.each(&)
  end
end

# Now we get all Enumerable methods for free!
collection = MyArray.new([1, 2, 4])

p collection.map { |x| x * 2 }.to_a # [2, 4, 8]
p collection.select { |x| x > 1 }.to_a # [2, 4]
p(collection.find { |x| x == 2 }) # 2
p(collection.all?(&:positive?)) # true

# Thinking in Ruby
#
# Enumerable demonstrates the power of Ruby's module system: include one
# module, implement one method (#each), and get 40+ methods for free.
# This is far more elegant than implementing an interface in Java (all methods
# required) or inheriting from a framework base class. Enumerable is the
# crown jewel of Ruby mixins — it's why map, select, find, and friends work
# on arrays, hashes, ranges, and your custom classes alike.
