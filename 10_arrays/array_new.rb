#!/usr/bin/env ruby
# frozen_string_literal: true

# array_new.rb — Array.new: size, default value, block

p Array.new(5)              # => [nil, nil, nil, nil, nil]
p Array.new(4, 0)           # => [0, 0, 0, 0]  (same object reference!)
p Array.new(4) { |i| i * i }  # => [0, 1, 4, 9] (block = unique objects)

# Beware: Array.new(3, "hello") shares the SAME string object
# Use the block form for unique objects:
names = Array.new(3) { 'hello' }
p names  # => ["hello", "hello", "hello"]

