#!/usr/bin/env ruby
# frozen_string_literal: true

# 09_timezones.rb — Work with UTC, local time, and zone offsets

# Every Time has a zone
departure = Time.new(2026, 6, 15, 8, 45, 0, "+02:00")
puts departure.zone       # => +02 (or CEST)
puts departure.utc_offset # => 7200 (seconds from UTC)

# Convert to UTC (creates new Time, original unchanged)
departure_utc = departure.utc
puts departure_utc         # => 2026-06-15 06:45:00 UTC

# locatime mutates current object — getlocal returns a new one (safe)
tokyo = departure_utc.getlocal("+09:00")
puts tokyo                 # => 2026-06-15 15:45:00 +0900
puts departure_utc         # still UTC

nyc = departure_utc.localtime("-04:00") # mutates departure_utc itself
puts nyc                   # => 2026-06-15 02:45:00 -0400

# Convert back to system timezone
system_time = nyc.getlocal
puts system_time           # => 2026-06-15 08:45:00 +0200
