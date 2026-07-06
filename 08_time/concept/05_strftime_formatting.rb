#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_strftime_formatting.rb — Format Time objects into human-readable strings with strftime

t = Time.now

# Common format specifiers
puts t.strftime('%Y-%m-%d')       # => 2026-05-08 (ISO date)
puts t.strftime('%d/%m/%Y')       # => 08/05/2026 (European date)
puts t.strftime('%H:%M:%S')       # => 14:30:00  (24h time)
puts t.strftime('%I:%M %p')       # => 02:30 PM  (12h with AM/PM)
puts t.strftime('%A, %B %d, %Y')  # => Friday, May 08, 2026
puts t.strftime('%a %b %e %R')    # => Fri May  8 14:30

# Custom formats
puts t.strftime('Logged at %H:%M on %Y-%m-%d') # => Logged at 14:30 on 2026-05-08

# Thinking in Ruby
#
# strftime is Ruby's string formatting powerhouse for time — it inherits
# the POSIX strftime format specifiers and adds nothing new, because the
# standard is already comprehensive. The beauty is composition: you embed
# % directives inside any string template. %Y-%m-%d (ISO date), %I:%M %p
# (12-hour clock), %A, %B %d, %Y (full date) — all from a single method.
# Ruby trusts you to learn the format specifiers rather than wrapping them
# in convenience methods.
