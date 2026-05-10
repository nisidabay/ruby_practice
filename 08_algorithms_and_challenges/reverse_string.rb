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
