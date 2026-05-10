#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Struct, OpenStruct, Set, Queue, Stack

# --- Struct: lightweight data class ---
Person = Struct.new(:name, :age)
carlos = Person.new("Carlos", 30)
puts carlos.name  # => Carlos
puts carlos.age   # => 30
carlos.age += 1
puts "Next year: #{carlos.age}"  # => 31

# --- Set: unique elements, fast lookups ---
require "set"
fruits = Set.new(["apple", "banana", "apple"])
puts fruits.inspect  # => #<Set: {"apple", "banana"}> — duplicate removed!
puts fruits.include?("apple")  # => true

# --- Queue (FIFO) ---
queue = []
queue.push("first")
queue.push("second")
puts queue.shift  # => first
puts queue.shift  # => second

# --- Stack (LIFO) ---
stack = []
stack.push("bottom")
stack.push("top")
puts stack.pop  # => top
puts stack.pop  # => bottom

# --- BONUS: OpenStruct — hash-like object with dot access ---
# require "ostruct"
# config = OpenStruct.new(host: "localhost", port: 5432)
# puts config.host  # => localhost
