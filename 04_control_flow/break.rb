#!/usr/bin/env ruby
# frozen_string_literal: true

# break.rb — break exits a loop immediately

# Find the first error in a log without reading the whole file.
# WITHOUT break — you'd scan the entire log every time.

def first_error(log)
  log.each do |line|
    break line if line.include?("ERROR")
  end
end

log = [
  "INFO  Started service",
  "INFO  Connected to DB",
  "ERROR Connection timeout",
  "INFO  Retrying...",
]
puts first_error(log)  # => "ERROR Connection timeout" (stops at line 3)
