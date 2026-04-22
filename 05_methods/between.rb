#!/usr/bin/env ruby
# Between
# This file contains Ruby code for between.

#!/usr/sbin/ruby
# frozen_string_literal: true

# Methods with multiple arguments
puts 20.between? 10, 15
puts 20.between?(10, 15)
puts 20.between?(10, 20)
puts 20.between?(20, 30)

puts 1.2.between?(1.1, 1.3)
puts(-10.between?(-13, -8))
puts(-8.3.between?(-9.5, -7.2))
