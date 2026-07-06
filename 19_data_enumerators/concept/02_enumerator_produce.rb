#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Generate an infinite sequence lazily — without precomputing everything.
# Example: An endless stream of IDs: 1, 2, 3, 4, ... forever.
#
# Solution: Enumerator.produce (Ruby 2.7+) — generates values on demand.
# Visibility: Returns an Enumerator. Call .next to pull one value at a time.

ids = Enumerator.produce(1) { |n| n + 1 }

puts ids.next  # => 1
puts ids.next  # => 2
puts ids.next  # => 3

# Usage: Take first N values
puts ids.take(5)  # => [4, 5, 6, 7, 8]  (continues from where we left off)

# Usage: Fibonacci sequence
fib = Enumerator.produce([0, 1]) { |a, b| [b, a + b] }.lazy.map { |a, _| a }
puts fib.take(10).force  # => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

# Usage: Timestamps every 5 seconds (simulated)
timestamps = Enumerator.produce(Time.now) { |t| t + 5 }
puts timestamps.take(3).map { |t| t.strftime('%H:%M:%S') }

# This could also be done like this:
# Manual loop with a counter (eager, not lazy):
#
#   n = 1
#   loop do
#     puts n
#     n += 1
#     break if n > 10
#   end
#
# Enumerator.produce is lazy — values are computed only when you ask.
#
# Thinking in Ruby
#
# Enumerator.produce embodies Ruby's embrace of lazy evaluation within an
# otherwise eager language. It generates infinite sequences on demand without
# pre-allocating memory — a functional programming concept made accessible with
# minimal syntax. The pattern mirrors Ruby's philosophy of making powerful
# abstractions feel natural: a block, a seed value, and a rule to generate the
# next element. That's all it takes.
