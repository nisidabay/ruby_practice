#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Process a large dataset efficiently — filter, transform, and output
# without loading everything into memory.
# Example: Parse a CSV of 1M rows, extract specific columns, convert to Data objects.
#
# Solution: Combine .lazy, Enumerator.produce, and Data.define.
# Visibility: Each step is lazy — memory stays constant regardless of input size.

# Simulate a large dataset with Enumerator.produce
Row = Data.define(:id, :name, :score)

rows = Enumerator.produce(1) { |n| n + 1 }.lazy.map do |id|
  Row.new(id: id, name: "User#{id}", score: rand(1..100))
end

# Pipeline: filter → transform → take
result = rows
  .select { |row| row.score > 80 }   # only high scores
  .map { |row| "#{row.name}: #{row.score}" }  # format output
  .take(5)                           # first 5 matches
  .force                             # materialize

puts 'Top scorers (from infinite stream):'
result.each { |line| puts "  #{line}" }

# Usage: Same pipeline with real data
puts "\nWith a real file (conceptual):"
puts <<~PIPELINE
  File.foreach('data.csv').lazy
    .map { |line| line.split(',') }
    .select { |fields| fields[2].to_i > 80 }
    .take(5)
    .each { |fields| puts fields[1] }
PIPELINE

# This could also be done like this:
# Eager version — loads everything into memory:
#
#   all_rows = (1..1_000_000).map { |id| Row.new(id, "User#{id}", rand(1..100)) }
#   top = all_rows.select { |r| r.score > 80 }.take(5)
#
# The lazy version never creates the million-element array.
#
# Thinking in Ruby
#
# This pipeline demonstrates Ruby's composable data processing: Data.define for
# value objects, Enumerator.produce for streams, .lazy for deferred evaluation,
# and method chaining for transformation — all working together without any
# external library. Ruby's collection API is designed so that lazy and eager
# processing share the same method names, making it easy to start simple and
# optimize later by adding a single `.lazy` call.
