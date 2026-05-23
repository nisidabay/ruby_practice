#!/usr/bin/env ruby
# frozen_string_literal: true

# range.rb — inclusive (..) vs exclusive (...) ranges

# WITHOUT ranges — manual arrays or loops:
#
#   (1..5).each { |n| puts n }  # => 1,2,3,4,5
#   # vs: [1,2,3,4,5].each — what if it's 1..1000?
#
# Two dots includes the end, three dots excludes it:

p (1..5).to_a    # => [1, 2, 3, 4, 5]
p (1...5).to_a   # => [1, 2, 3, 4]

# Ranges work with case, slice, and Array creation:
case 404
when 200..299 then puts "Success"
when 400..499 then puts "Client error"  # => this one
when 500..599 then puts "Server error"
end
