#!/usr/bin/env ruby

# array_new.rb — Array.new: size, default value, block
#
# NOTE: This file does NOT use `# frozen_string_literal: true`.
# That pragma would freeze every string literal, so `'hello' << ', world!'`
# would raise FrozenError instead of demonstrating the shared-reference
# pitfall. The whole point here is to show in-place mutation, which requires
# mutable strings. In production code you'd keep the freeze pragma to catch
# accidental mutations early, but this file is a teaching example.

puts '=== Array.new(size) ==='
p Array.new(5)              # => [nil, nil, nil, nil, nil]

puts "\n=== Array.new(size, default) — warning: shared reference ==="
zeros = Array.new(4, 0)
p zeros                     # => [0, 0, 0, 0]
zeros[0] += 1               # safe: Integers are immutable, += reassigns
p zeros                     # => [1, 0, 0, 0]

puts "\n=== Shared-reference pitfall with mutable objects ==="
# Array.new(3, "hello") creates ONE string, repeated 3 times
shared = Array.new(3, 'hello')
p shared # => ["hello", "hello", "hello"]
puts "All same object? #{shared[0].equal?(shared[1])}" # => true

shared[0] << ', world!'     # mutates the ONE shared string!
p shared                    # => ["hello, world!", "hello, world!", "hello, world!"]

puts "\n=== Block form: Array.new(size) { |i| ... } — unique objects ==="
# The block runs once per element; each gets its own object
squares = Array.new(4) { |i| i * i }
p squares                   # => [0, 1, 4, 9]

names = Array.new(3) { 'hello' }
p names                     # => ["hello", "hello", "hello"]
puts "All same object? #{names[0].equal?(names[1])}" # => false

names[0] << ', world!'      # only mutates names[0]
p names                     # => ["hello, world!", "hello", "hello"]

# Thinking in Ruby
#
# Array.new with a default value creates a SHARED reference — all elements
# point to the same object. This is a classic Ruby gotcha documented here
# because the block form (Array.new(size) { default }) creates independent
# objects. Ruby's philosophy: the default-value form is a convenience
# shortcut; the block form is the safe default.
