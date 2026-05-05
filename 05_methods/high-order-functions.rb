#!/usr/bin/env ruby
# frozen_string_literal: true

# high-order-functions.rb — functions that take or return functions

def filter(array, condition)
  array.select { |e| condition.call(e) }
end

even = ->(n) { n.even? }
puts filter([1, 2, 3, 4, 5, 6], even).inspect  # => [2, 4, 6]

def create_multiplier(factor)
  ->(x) { x * factor }
end

double = create_multiplier(2)
triple = create_multiplier(3)

puts double.call(5)  # => 10
puts triple.call(5)  # => 15
