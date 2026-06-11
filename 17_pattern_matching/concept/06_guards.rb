#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Add conditions to a pattern — match structure AND logic.
# Example: Match a pair [a, b] only if a is greater than b.
#
# Solution: Guards with if/unless — pattern matches first, then condition checks.
# Visibility: The guard runs AFTER the pattern matches. If guard fails, next pattern tries.

data = [10, 3]

case data
in [a, b] if a > b
  puts "#{a} is greater than #{b}"
in [a, b] if a < b
  puts "#{a} is less than #{b}"
in [a, b]
  puts "#{a} equals #{b}"
end
# => 10 is greater than 3

# Usage: Guards on hash patterns too
response = { status: 200, body: '{"error": "timeout"}' }
case response
in { status: code, body: msg } if code >= 500
  puts "Server error #{code}: #{msg}"
in { status: code, body: msg } if msg.include?('error')
  puts "Error in response (status #{code}): #{msg}"
in { status: 200, body: msg }
  puts "OK: #{msg}"
end
# => Error in response (status 200): {"error": "timeout"}

# This could also be done like this:
# Nested if inside the branch (less elegant):
#
#   case data
#   in [a, b]
#     if a > b
#       puts "#{a} is greater"
#     end
#   end
#
# Guards keep the condition at the pattern level — cleaner separation.
