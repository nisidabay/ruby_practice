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
