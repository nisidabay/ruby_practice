#!/usr/bin/env ruby
# frozen_string_literal: true

# for_loop.rb — for loops (use .each instead in real code)

for i in 1..5
  puts "Iteration #{i}"
end

fruits = %w[apple banana cherry]
for fruit in fruits
  puts "I like #{fruit}"
end

for key, value in { name: 'John', age: 30 }
  puts "#{key}: #{value}"
end

# Prefer this instead:
(1..5).each { |i| puts "Iteration #{i}" }
fruits.each { |fruit| puts "I like #{fruit}" }
