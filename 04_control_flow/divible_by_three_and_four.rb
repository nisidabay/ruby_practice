#!/usr/bin/env ruby
# frozen_string_literal: true

# divisible_by_three_and_four.rb

def divisible_by_three_and_four(value)
  (value % 3).zero? && (value % 4).zero?
end

puts divisible_by_three_and_four(3)   # => false
puts divisible_by_three_and_four(4)   # => false
puts divisible_by_three_and_four(12)  # => true
puts divisible_by_three_and_four(18)  # => false
puts divisible_by_three_and_four(24)  # => true
