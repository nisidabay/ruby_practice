#!/usr/bin/env ruby
# frozen_string_literal: true

# 08_date_class.rb — Date objects (date-only, no time). Needs require 'date'

require 'date'

# Today's date
today = Date.today
puts today # => 2026-05-08

# Specific date
release = Date.new(2026, 9, 1)
puts release # => 2026-09-01

# Components
puts release.year   # => 2026
puts release.month  # => 9
puts release.day    # => 1
puts release.tuesday? # => true

# Date arithmetic (result is a Rational of days)
days_left = release - today
puts "#{days_left.to_i} days until release" # => 116 days

# Parse a date string
start = Date.parse('2026-01-01')
puts start # => 2026-01-01
