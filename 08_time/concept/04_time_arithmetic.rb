#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_time_arithmetic.rb — Add, subtract, and compare Time objects

start = Time.new(2026, 1, 10, 9, 0, 0)
finish = Time.new(2026, 1, 10, 17, 0, 0)

# Difference in seconds
worked = finish - start
puts "Seconds worked: #{worked.to_i}"  # => 28800 (8 hours)

# Add/subtract seconds
an_hour_later = start + 3600
puts an_hour_later                      # => 2026-01-10 10:00:00 +0100
puts finish - 1800                      # => 2026-01-10 16:30:00 +0100

# Comparisons
puts finish > start    # => true
puts finish < start    # => false

# Time between two dates
checkin = Time.new(2026, 3, 20)
checkout = Time.new(2026, 3, 25)
days = (checkout - checkin) / 86400
puts "#{days.to_i} days"  # => 5 days
