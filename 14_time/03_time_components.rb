#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_time_components.rb — Extract individual pieces from a Time object

departure = Time.new(2026, 6, 15, 8, 45, 0)

puts departure.year    # => 2026
puts departure.month   # => 6
puts departure.day     # => 15
puts departure.hour    # => 8
puts departure.min     # => 45
puts departure.sec     # => 0
puts departure.wday    # => 1 (0=Sunday, 1=Monday)
puts departure.yday    # => 166 (day of year, 1-366)
puts departure.monday? # => true
puts departure.dst?    # => true (summer in Europe)
