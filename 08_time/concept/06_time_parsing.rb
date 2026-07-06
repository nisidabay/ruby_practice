#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_time_parsing.rb — Parse a date string into a Time object using different methods

require 'time'

puts '--- 1. Guessing the format with Time.parse ---'

flight = Time.parse('2026-07-15 06:30:00')
puts flight               # => 2026-07-15 06:30:00 +0200
puts flight.wday          # => 3 (Wednesday)

deadline = Time.parse('2026-12-31')
puts deadline             # => 2026-12-31 00:00:00 +0100

puts "\n--- 2. Strict rules with Time.strptime ---"
# strptime stands for "string parse time".
# You give it the exact pattern to look for, which is safer for custom formats.

custom_string = '15-07-2026 @ 06:30 AM'
# %d = day, %m = month, %Y = 4-digit year
# %I = 12-hour clock, %M = minute, %p = AM/PM
strict_flight = Time.strptime(custom_string, '%d-%m-%Y @ %I:%M %p')
puts strict_flight # => 2026-07-15 06:30:00 +0200

puts "\n--- 3. Dedicated fast parsers ---"
# If you know you have a standard format like ISO 8601 or an HTTP date,
# Ruby has built-in methods that are faster and safer than Time.parse.

# Strict ISO 8601 with timezone
utc_event = Time.iso8601('2026-06-01T12:00:00Z')
puts utc_event # => 2026-06-01 12:00:00 UTC
puts "UTC: #{utc_event.utc?}" # => UTC: true

# Web server format (RFC 2616)
web_time = Time.httpdate('Wed, 15 Jul 2026 06:30:00 GMT')
puts web_time # => 2026-07-15 06:30:00 UTC

# Thinking in Ruby
#
# Ruby's time parsing has layers: Time.parse (flexible, best-effort),
# Time.strptime (strict, you define the format), and dedicated parsers
# (Time.iso8601, Time.httpdate) for standard formats. This layered approach
# means you start with .parse for quick scripts, graduate to .strptime
# for production, and use the dedicated methods for known formats. Each
# level trades convenience for safety — Ruby lets you choose the trade-off.
