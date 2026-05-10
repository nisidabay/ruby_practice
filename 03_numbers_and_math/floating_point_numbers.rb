#!/usr/bin/env ruby
# frozen_string_literal: true

# floating_point_numbers.rb — float division vs integer division

# WITHOUT floats — Ruby truncates:
#
#   puts 10 / 3     # => 3  (integer division — surprise!)
#
# WITH floats — you get the real answer:

puts 10.0 / 3       # => 3.3333333333333335
puts 10 / 3.0       # => 3.3333333333333335  (either side works)
puts 10.fdiv(3)     # => 3.3333333333333335  (explicit float division)

# Integer division still has uses:
puts 10 / 3         # => 3  (how many full groups of 3?)
puts 22.divmod(7)   # => [3, 1]  (3 days, 1 hour left over)
