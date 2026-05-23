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

puts collection.map { |x| x * 2 }.to_a.inspect # [2, 4, 8]
puts collection.select { |x| x > 1 }.to_a.inspect # [2, 4]
puts(collection.find { |x| x == 2 }) # 2
puts(collection.all?(&:positive?)) # true
