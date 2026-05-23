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
