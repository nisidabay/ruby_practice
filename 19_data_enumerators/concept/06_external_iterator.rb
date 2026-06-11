#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Control iteration manually — step forward, peek ahead, rewind.
# Example: Parse a token stream where you need to look at the next token without consuming it.
#
# Solution: Enumerator as external iterator — .next, .peek, .rewind.
# Visibility: Works on any Enumerator. Raises StopIteration at the end.

tokens = %w[if x > 10 then print x end].each

puts tokens.next  # => if
puts tokens.next  # => x
puts tokens.peek  # => >  (look ahead without consuming)
puts tokens.peek  # => >  (still there)
puts tokens.next  # => >  (now consumed)

# Usage: Rewind — start over
tokens.rewind
puts tokens.next  # => if  (back to the beginning)

# Usage: Manual iteration with StopIteration
numbers = (1..3).each
loop do
  puts numbers.next
end
# => 1, 2, 3, then StopIteration (loop handles it)

# This could also be done like this:
# Internal iteration (each with block) — simpler for most cases:
#
#   tokens.each { |t| puts t }
#
# External iteration (next/peek/rewind) is for when you need
# fine-grained control — parsers, state machines, lookahead.
