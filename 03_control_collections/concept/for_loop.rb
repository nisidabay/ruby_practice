#!/usr/bin/env ruby
# frozen_string_literal: true

# for_loop.rb — for loops (legacy — prefer .each in real code)

# for is Ruby's C-style construct. In practice, use .each:
#
#   services = %w[web worker scheduler]
#   services.each { |name| puts "Starting #{name}..." }
#
# for is here so you recognize it in others' code:

for name in %w[web worker scheduler]
  puts "Starting #{name}..."
end

# Thinking in Ruby
#
# for is syntactic sugar for .each — there is no C-style for construct in
# Ruby. Modern idiomatic Ruby prefers the explicit .each do...end form
# because blocks introduce a new scope while for does not, making the
# block form safer against accidental variable leakage.
