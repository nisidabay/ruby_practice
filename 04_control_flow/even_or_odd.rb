#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Even or odd
# This file contains Ruby code for even or odd.

# Check if a number is even or odd

def transform_number(value)
  value.even? ? value + 2 : value - 3
end

[2, 0, 13, 9].each { |num| puts transform_number(num) }
