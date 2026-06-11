#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Match against multiple possible values in one pattern.
# Example: Treat 301, 302, and 307 all as "redirect" — same handling.
#
# Solution: Alternatives with | — "match this OR that".
# Visibility: Works with literals, constants, and nested patterns.

status = 302

case status
in 200
  puts 'Success'
in (301 | 302 | 307 | 308)
  puts 'Redirect'
in (400 | 401 | 403 | 404)
  puts 'Client Error'
in (500 | 502 | 503)
  puts 'Server Error'
end
# => Redirect

# Usage: Alternatives work inside larger patterns too
response = { status: 404, body: 'Not Found' }
case response
in { status: (200 | 201), body: msg }
  puts "Created: #{msg}"
in { status: (400 | 404), body: msg }
  puts "Client error: #{msg}"
end
# => Client error: Not Found

# This could also be done like this:
# case/when with multiple values (older style):
#
#   case status
#   when 301, 302, 307, 308 then puts 'Redirect'
#   end
#
# But case/when can't nest alternatives inside hash/array patterns.
# case/in can: `in {status: (200 | 201)}` — that's the difference.
