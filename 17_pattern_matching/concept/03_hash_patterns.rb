#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Extract specific keys from a hash and ignore the rest.
# Example: Parse an API response — you only care about :status and :body.
#
# Solution: Hash patterns with {key: variable} — extracts and binds in one step.
# Visibility: Keys you don't mention are ignored. Missing required keys → no match.

response = { status: 200, body: 'OK', headers: { 'Content-Type' => 'text/html' },
             timestamp: '2026-06-11', server: 'nginx' }

case response
in { status: 200, body: msg }
  puts "Success: #{msg}"
in { status: 404 }
  puts 'Not found'
in { status: code, body: msg }
  puts "#{code}: #{msg}"
end
# => Success: OK

# Usage: Match nested hashes too
config = { db: { host: 'localhost', port: 5432 }, cache: true }
case config
in { db: { host: h, port: p } }
  puts "Database at #{h}:#{p}"
end
# => Database at localhost:5432

# This could also be done like this:
# Without pattern matching — manual key access:
#
#   if response[:status] == 200
#     msg = response[:body]
#     puts "Success: #{msg}"
#   end
#
# Hash patterns are cleaner when you need multiple keys and want to
# ignore the rest. No `fetch` calls, no nil checks.

# Thinking in Ruby
#
# Hash patterns destructure by key and bind in one step. Keys you don't
# mention are ignored, keys you do mention must exist or the pattern
# doesn't match. Nested hashes destructure recursively. This is Ruby's
# answer to the "dig and check" pattern — instead of fetch then check
# nil, you say "is it this shape?" and get the values if yes.
