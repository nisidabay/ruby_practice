#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Match against the value of an existing variable, not a literal.
# Example: You have `expected = 200` and want to match only if status equals it.
#
# Solution: Pin operator ^ — "match against this variable's value, don't rebind."
# Visibility: Without ^, the variable gets reassigned. With ^, it's a guard.

expected = 200
response = { status: 200, body: 'OK' }

case response
in { status: ^expected, body: msg }
  puts "Expected status #{expected}: #{msg}"
in { status: code, body: msg }
  puts "Unexpected status #{code}: #{msg}"
end
# => Expected status 200: OK

# Usage: Without ^, `expected` would be REBOUND to the matched value
response2 = { status: 404, body: 'Not Found' }
case response2
in { status: expected, body: msg }  # NO pin — expected gets overwritten!
  puts "expected is now #{expected}"  # => 404 (reassigned!)
end

# This could also be done like this:
# Use a guard clause instead of pin:
#
#   case response
#   in { status: code, body: msg } if code == expected
#     puts "Expected: #{msg}"
#   end
#
# Pin is cleaner for single-variable checks. Guards are better for
# complex conditions (file 06).

# Thinking in Ruby
#
# The pin operator ^ turns a variable reference into a matcher — match
# against the variable's value instead of rebinding it. Without ^, the
# variable gets overwritten in the match. This subtle distinction is
# critical: do you want to capture (no pin) or compare (pin)? Ruby's
# pattern matching makes the intent explicit.
