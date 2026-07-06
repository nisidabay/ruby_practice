#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_specific_times.rb — Create Time objects for specific dates

# Time.new with full arguments (year, month, day, hour, min, sec)
xmas = Time.new(2025, 12, 25, 10, 30, 0)
puts xmas # => 2025-12-25 10:30:00 +0100

# Shorthand: Time.local (same as Time.new, local timezone)
xmas = Time.local(2025, 12, 25, 10, 30, 0)
puts xmas # => 2025-12-25 10:30:00 +0100

# Time.utc: same arguments, but in UTC
xmas_utc = Time.utc(2025, 12, 25, 10, 30, 0)
puts xmas_utc # => 2025-12-25 10:30:00 UTC

# Thinking in Ruby
#
# Time.new, Time.local, and Time.utc all create Time objects with the same
# arguments — only the timezone changes. This is Ruby's "3 ways to say the
# same thing" philosophy: your code can be explicit about the timezone
# context. Time.local uses the system timezone, Time.utc uses UTC. The
# consistency in argument order (year, month, day, hour, min, sec) across
# all three makes them trivially swappable.
