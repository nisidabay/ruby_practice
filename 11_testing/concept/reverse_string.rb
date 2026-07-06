#!/usr/bin/env ruby
# frozen_string_literal: true

# reverse_string.rb — reverse via negative indexing: string[-1], string[-2], ...

# WITHOUT reverse — build it yourself:
#
#   def backwards(str)
#     (1..str.length).map { |i| str[-i] }.join
#   end
#
# WITH reverse — built in:

puts "Carlos".reverse  # => solraC

# Thinking in Ruby
#
# reverse is pure Ruby elegance — String#reverse handles full Unicode
# correctly and returns a new string. Negative indexing (str[-1]) builds
# the same logic manually when you need custom behavior. This is Ruby's
# gift: one-line convenience AND the building blocks to go beyond.
