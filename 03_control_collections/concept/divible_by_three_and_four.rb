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

# Thinking in Ruby
#
# Ruby uses .zero? as a predicate on the result of modulo — it reads more
# naturally than (value % 3 == 0). Compound boolean logic with && and ||
# lets you express multiple conditions as readable English-like
# expressions. The method returns a boolean directly, no explicit true/false
# branches needed.
