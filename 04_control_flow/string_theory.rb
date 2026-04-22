#!/usr/bin/env ruby
# frozen_string_literal: true

# String Operations
# This file demonstrates string manipulation techniques.
# Shows interpolation, concatenation, and various string methods.

def string_theory(value)
  value.include?('B') || value.length > 4 ? true : false
end
puts string_theory('Big Mac')
puts string_theory('Bank')
puts string_theory('refrigerator')
puts string_theory('boy')
puts string_theory('car')
