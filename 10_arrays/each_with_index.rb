#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Each with index
# This file contains Ruby code for each with index.

# each_with_index method in Ruby is similar to `each`, but it provides access to
# both the element and its index within the enumerable object. It returns an
# enumerable object that yields the element and its index. This is useful when
# you need to perform operations that depend on the index, such as modifying
# elements based on their position.

[1, 2, 3, 4, 5].each_with_index { |value, index| puts "#{value} at index #{index} is odd" if value.odd? }

puts '-'

# Long version
[1, 2, 3, 4, 5].each_with_index do |value, index|
  if value.odd?
    puts "value #{value} at index #{index} is odd"
  end
end
