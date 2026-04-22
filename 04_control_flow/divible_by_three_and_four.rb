#!/usr/bin/env ruby
# Divible by three and four
# This file contains Ruby code for divible by three and four.

# frozen_string_literal: true
# !/usr/bin/env ruby
def divisible_by_three_and_four(value)
  (value % 3 == 0) && (value % 4 == 0) ? true : false
end

puts divisible_by_three_and_four(3)
puts divisible_by_three_and_four(4)
puts divisible_by_three_and_four(12)
puts divisible_by_three_and_four(18)
puts divisible_by_three_and_four(24)
