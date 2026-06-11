#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need simple value objects — immutable, easy to compare, no boilerplate.
# Example: A Point with x and y coordinates. Struct works but is mutable.
#
# Solution: Data class (Ruby 3.2+) — immutable, == by value, no setters.
# Visibility: PUBLIC — behaves like a class but with value semantics.

Point = Data.define(:x, :y)

a = Point.new(3, 4)
b = Point.new(3, 4)
c = Point.new(5, 6)

puts "a == b? #{a == b}"  # => true  (value equality)
puts "a == c? #{a == c}"  # => false
puts "a: #{a.inspect}"    # => #<data Point x=3, y=4>

# Usage: Access members like methods
puts "x=#{a.x}, y=#{a.y}"  # => x=3, y=4

# Usage: with — create a copy with one field changed
d = a.with(x: 10)
puts "d: #{d.inspect}"  # => #<data Point x=10, y=4>
puts "a unchanged: #{a.inspect}"  # => #<data Point x=3, y=4>

# This could also be done like this:
# Struct — older, mutable, more features:
#
#   Point = Struct.new(:x, :y)
#   a = Point.new(3, 4)
#   a.x = 10  # mutable — can change after creation
#
# Use Data for immutable value objects (like Rust's structs).
# Use Struct when you need mutable records with optional defaults.
