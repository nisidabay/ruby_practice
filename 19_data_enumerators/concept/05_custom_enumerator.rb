#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Build a custom enumerator that generates values with complex logic.
# Example: A random dice roller that yields results on demand.
#
# Solution: Enumerator.new with a block — you control when and what to yield.
# Visibility: The block receives a Yielder object. Call yielder << value to emit.

dice = Enumerator.new do |yielder|
  loop do
    yielder << rand(1..6)  # emit a value
  end
end

puts dice.take(5)  # => [3, 6, 1, 4, 2]  (random)

# Usage: Generator with state
counter = Enumerator.new do |yielder|
  n = 0
  loop do
    yielder << n
    n += 2  # only even numbers
  end
end

puts counter.take(5)  # => [0, 2, 4, 6, 8]

# Usage: Read a file as an enumerator
lines = Enumerator.new do |yielder|
  File.foreach('/etc/hostname') { |line| yielder << line.chomp }
end
puts lines.to_a  # => contents of /etc/hostname

# This could also be done like this:
# Enumerator.produce (simpler, no Yielder):
#
#   counter = Enumerator.produce(0) { |n| n + 2 }
#
# Use Enumerator.new when you need complex logic (multiple yields,
# file reading, external API calls). Use produce for simple sequences.
#
# Thinking in Ruby
#
# Enumerator.new with a Yielder gives you full control over generator logic in
# a way that's hard to achieve in many languages. The Yielder acts as a bridge
# between imperative generation logic (inside the block) and lazy consumption
# (outside the block). This pattern — yielding values one at a time from complex
# state machines — is Ruby's answer to Python's generator functions, achieved
# with blocks and closures rather than special syntax.
