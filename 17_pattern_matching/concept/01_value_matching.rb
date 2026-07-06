#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Match a value against several possibilities — cleaner than if/elsif.
# Example: Classify an HTTP status code: 200 → success, 404 → not found, etc.
#
# Solution: case/in — Ruby's pattern matching (Ruby 3.0+).
# Visibility: Works anywhere case/when works, but with destructuring power.

status = 404

case status
in 200
  puts 'Success'
in 301 | 302
  puts 'Redirect'
in 404
  puts 'Not Found'
in 500
  puts 'Server Error'
else
  puts "Unknown: #{status}"
end
# => Not Found

# Usage: case/in is exhaustive — Ruby warns if you miss cases.
# Unlike case/when (which uses ===), case/in uses pattern matching.

# This could also be done like this:
# case/when — the older style (no destructuring, uses ===):
#
#   case status
#   when 200       then puts 'Success'
#   when 301, 302  then puts 'Redirect'
#   when 404       then puts 'Not Found'
#   when 500       then puts 'Server Error'
#   else puts "Unknown: #{status}"
#   end
#
# case/in is more powerful (destructuring, guards, pin) but case/when
# is fine for simple value matching.

# Thinking in Ruby
#
# case/in is Ruby's pattern matching entry point — it replaces case/when
# when you need more than === equality. Value matching is the simplest
# pattern: match a literal, or use | for alternatives, or else for
# everything else. Ruby's pattern matching scales from simple value
# checks to deep structural destructuring, all with the same syntax.
