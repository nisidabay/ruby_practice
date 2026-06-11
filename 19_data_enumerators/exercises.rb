#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Data & Enumerators practice

puts '=== Exercise 1: Data class ==='
Point = Data.define(:x, :y)
p1 = Point.new(3, 4)
p2 = Point.new(3, 4)
puts "p1 == p2? #{p1 == p2}"
puts "p1.with(x: 10): #{p1.with(x: 10)}"

puts "\n=== Exercise 2: Enumerator.produce ==="
ids = Enumerator.produce(1) { |n| n + 1 }
puts "First 5 IDs: #{ids.take(5)}"

puts "\n=== Exercise 3: with_object ==="
words = %w[apple banana apricot blueberry]
grouped = words.each.with_object(Hash.new { |h, k| h[k] = [] }) { |w, h| h[w[0]] << w }
puts "Grouped: #{grouped}"

puts "\n=== Exercise 4: Lazy pipeline ==="
result = (1..100).lazy.select(&:even?).map { |n| n * n }.take(5).force
puts "First 5 even squares: #{result}"

puts "\n=== Exercise 5: Custom enumerator ==="
dice = Enumerator.new { |y| loop { y << rand(1..6) } }
puts "Dice rolls: #{dice.take(5)}"

puts "\n=== Exercise 6: External iterator ==="
tokens = %w[if x > 10 then print].each
puts "First: #{tokens.next}, Peek: #{tokens.peek}, Next: #{tokens.next}"
