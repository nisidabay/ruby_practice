#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Destructure a value without a full case/in block — one-liner extraction.
# Example: Pull :status and :body from a hash in a single expression.
#
# Solution: Rightward assignment => — "match this expression against that pattern."
# Visibility: Works anywhere an expression is valid. Raises NoMatchingPatternError if no match.

response = { status: 200, body: 'OK', headers: {} }

# Extract in one line:
response => { status: code, body: msg }

puts "Status: #{code}"  # => Status: 200
puts "Body: #{msg}"     # => Body: OK

# Usage: Works with arrays too
data = [1, 2, 3]
data => [first, *rest]
puts "First: #{first}, Rest: #{rest}"  # => First: 1, Rest: [2, 3]

# Usage: Deep destructuring
config = { db: { host: 'localhost', port: 5432 } }
config => { db: { host: h, port: p } }
puts "DB at #{h}:#{p}"  # => DB at localhost:5432

# This could also be done like this:
# Manual extraction (more lines, more error-prone):
#
#   code = response[:status]
#   msg  = response[:body]
#
# Rightward assignment is ideal for "I know the shape, just give me the parts."
# It fails loudly if the shape is wrong — no silent nils.

# Thinking in Ruby
#
# Rightward assignment => is destructuring as a one-liner: extract
# values from a known shape without a case block. It raises
# NoMatchingPatternError if the shape doesn't match — no silent nil
# bugs. This is Ruby's take on pattern matching for the 80% case:
# "I know this data structure, just give me the pieces."
