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

orders = ["ORD-001", "ORD-002", "ORD-003"]

orders.each do |order|
  puts "Processing #{order}..."
end
