#!/usr/bin/env ruby
# frozen_string_literal: true

# 07_epoch_timestamps.rb — Unix epoch: seconds since Jan 1, 1970

# to_i: number of seconds since epoch
now = Time.now
puts now.to_i    # => 1700000000 (varies)

# Time.at: convert an epoch integer back to Time
past = Time.at(0)
puts past        # => 1970-01-01 00:00:00 +0100 (UTC+1 at your location)

future = Time.at(2_000_000_000)
puts future      # => 2033-05-18 05:33:20 +0200

# Float for sub-second precision
precise = Time.at(1000.5)
puts precise     # => 1970-01-01 01:16:40 +0100
puts precise.usec  # => 500000 (microseconds)
