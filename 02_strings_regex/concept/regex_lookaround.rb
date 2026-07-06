#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to match something only when preceded or followed by context.
# Example: Extract dollar amounts — match "25.00" but only when preceded by "$".
# Solution: Lookahead (?=...) and lookbehind (?<=...) — zero-width assertions.
# Visibility: Use when context determines relevance but shouldn't be consumed.

# Positive lookbehind: extract numbers preceded by $
prices = 'Item: $25.00, Tax: $5.00, Total: 30.00'
dollars = prices.scan(/(?<=\$)\d+\.\d+/)
puts "Dollar amounts: #{dollars}" # => ["25.00", "5.00"] (30.00 excluded)

# Negative lookahead: find words NOT followed by punctuation
text = 'hello, world. how are you? fine thanks'
words = text.scan(/\b\w+\b(?![\.,?!])/)
puts "Words without trailing punct: #{words}" # => ["fine", "thanks"]

# Positive lookahead: match only numbers followed by "ERROR" in logs
logs = <<~LOGS
  404 ERROR: not found
  200 ok
  500 ERROR: timeout
LOGS
error_codes = logs.scan(/\d+(?= ERROR)/)
puts "Error codes: #{error_codes}" # => ["404", "500"]

# Negative lookbehind: find "server" NOT preceded by "db-"
hosts = ['db-prod', 'web-prod', 'db-staging', 'web-staging']
web = hosts.grep(/(?<!db-)prod/)
puts "Non-db prod hosts: #{web}" # => ["web-prod"]

# This could also be done like this:
# Without lookbehind: prices.scan(/\$(\d+\.\d+)/) then map $1 — works but captures
# the $ group, polluting $1. Lookarounds keep the match exactly what you want.

# Thinking in Ruby
#
# Ruby supports all four lookaround assertions (positive/negative,
# lookahead/lookbehind) — zero-width checks that constrain a match
# without consuming characters. This keeps the matched text exactly what
# you want, avoiding the post-match stripping that other approaches
# require.
