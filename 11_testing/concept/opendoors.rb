#!/usr/bin/env ruby
# frozen_string_literal: true

# opendoors.rb — Range#step for skipping: every Nth, not every one

# WITHOUT step — manual counter arithmetic:
#
#   (1..5).each do |n|
#     puts n if n.even?  # print only evens — but you still visit ALL numbers
#   end
#
# WITH step — skip directly:

(2..10).step(2) { |n| puts n }  # => 2, 4, 6, 8, 10
(3..15).step(3) { |n| puts n }  # => 3, 6, 9, 12, 15

# Thinking in Ruby
#
# Range#step embodies Ruby's "skip the loop, not the values" philosophy.
# Instead of visiting every element and filtering, step jumps directly
# to the Nth position. Combined with ranges, it models intervals
# naturally — step 2 means "every other," step 3 means "every third."
# The pattern reads as math, not machinery.
