#!/usr/bin/env ruby
# frozen_string_literal: true

# between.rb — testing if value falls in a range

puts 20.between?(10, 15)      # => false
puts 20.between?(10, 20)      # => true (inclusive)
puts 20.between?(20, 30)      # => true (inclusive lower bound)

puts 1.2.between?(1.1, 1.3)   # => true
puts (-10).between?(-13, -8)  # => true
puts (-8.3).between?(-9.5, -7.2) # => true
