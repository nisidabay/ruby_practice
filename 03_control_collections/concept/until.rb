#!/usr/bin/env ruby
# frozen_string_literal: true

# until.rb — loop until a condition becomes true

# until is "while not". Reads better when you think in negatives:
#
#   "until connected, retry"  →  English-like
#   "while not connected, retry"  →  double negative, harder

retries = 0
until retries >= 3
  puts "Retry ##{retries + 1}..."
  retries += 1
end

# Thinking in Ruby
#
# until is Ruby's inverted while — it loops while the condition is FALSE.
# This reads more naturally for negative conditions: "until connected"
# rather than "while not connected". Ruby is one of few languages with
# this construct, reflecting its design priority of expressive clarity
# over minimal keyword count.
