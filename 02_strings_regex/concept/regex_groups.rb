#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to extract structured fields from a log line or text record.
# Example: "2026-06-25 ERROR: Connection timeout from 10.0.0.1"
# Solution: Capturing groups with () let you pluck submatches by position or name.
# Visibility: Use whenever you need pieces of a match, not just the whole thing.

line = '2026-06-25 ERROR: Connection timeout from 10.0.0.1'

# Positional captures: each (...) becomes $1, $2... or match[1], match[2]
pattern = /(\d{4}-\d{2}-\d{2}) (\w+): (.+) from (\d+\.\d+\.\d+\.\d+)/
match = line.match(pattern)
puts "Date: #{match[1]}"     # => 2026-06-25
puts "Severity: #{match[2]}" # => ERROR
puts "Message: #{match[3]}"  # => Connection timeout
puts "IP: #{match[4]}"       # => 10.0.0.1

# Named captures use (?<name>...) — self-documenting and order-independent
named = /(?<date>\d{4}-\d{2}-\d{2}) (?<sev>\w+): (?<msg>.+) from (?<ip>\d+\.\d+\.\d+\.\d+)/
if (m = line.match(named))
  puts "#{m[:sev]} on #{m[:date]}: #{m[:msg]} (from #{m[:ip]})"
end

# Backreference \1 in gsub: reference a group inside the replacement string
# Swap "last, first" → "first last"
puts 'Simpson, Homer'.gsub(/(\w+), (\w+)/, '\2 \1') # => Homer Simpson

# This could also be done like this:
# match = line.match(pattern) and manually doing $1, $2, $3 individually.
# Named captures are better because the field names explain themselves.

# Thinking in Ruby
#
# Ruby supports both positional ($1, $2...) and named (?<name>...) capture
# groups. Named captures make regexes self-documenting — the field name
# lives inside the pattern. Backreference in gsub (\\1 in replacement
# strings) gives a concise way to reformat matched text without chaining
# multiple operations.
