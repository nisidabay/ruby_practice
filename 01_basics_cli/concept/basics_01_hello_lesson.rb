#!/usr/bin/env ruby
# frozen_string_literal: true

# hello_lesson.rb — #each replaces index loops

# WITHOUT #each — you track the index yourself:
#
#   orders = ["ORD-001", "ORD-002", "ORD-003"]
#   i = 0
#   while i < orders.length
#     puts "Processing #{orders[i]}..."
#     i += 1
#   end
#
# WITH #each — Ruby handles the iteration:

orders = %w[ORD-001 ORD-002 ORD-003]

orders.each do |order|
  puts "Processing #{order}..."
end

# Thinking in Ruby
#
# #each is Ruby's idiomatic replacement for index-based loops. Where other
# languages force you to manage counters and bounds, Ruby's block-based
# iteration keeps intent clear and eliminates off-by-one errors. The block
# variable scopes naturally — no risk of leaking the loop index.
