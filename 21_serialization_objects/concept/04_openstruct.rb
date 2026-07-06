#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need a quick object with arbitrary attributes — without defining a class.
# Example: Parse a CSV row into an object where you can do row.name instead of row[:name].
#
# Solution: OpenStruct (stdlib) — method access to hash-like data.
# Visibility: `require 'ostruct'`. Any key becomes a method.

require 'ostruct'

# Create from a Hash
user = OpenStruct.new(name: 'Alice', email: 'alice@example.com', age: 30)
puts "Name: #{user.name}"    # => Alice
puts "Email: #{user.email}"  # => alice@example.com

# Usage: Add attributes dynamically
user.role = 'admin'
puts "Role: #{user.role}"  # => admin

# Usage: Convert back to Hash
puts "As hash: #{user.to_h}"

# Usage: Compare two OpenStructs
a = OpenStruct.new(x: 1, y: 2)
b = OpenStruct.new(x: 1, y: 2)
puts "a == b? #{a == b}"  # => true  (value equality)

# This could also be done like this:
# Data.define — immutable, faster, but fixed attributes:
#
#   User = Data.define(:name, :email, :age)
#   user = User.new('Alice', 'alice@example.com', 30)
#   user.name  # works
#   user.role = 'admin'  # ERROR — immutable
#
# Use OpenStruct for dynamic/unknown attributes (CSV parsing, API responses).
# Use Data for known, fixed attributes (value objects).
#
# Thinking in Ruby
#
# OpenStruct fills a specific niche in Ruby's type system: dynamic objects where
# you don't know the attribute names ahead of time. It bridges the gap between
# rigid classes and flexible hashes, letting you call methods that don't exist
# at compile time. This reflects Ruby's dynamic nature — objects can grow and
# change at runtime. Use it when parsing unpredictable data, reach for Data or
# Struct when the shape is known.
