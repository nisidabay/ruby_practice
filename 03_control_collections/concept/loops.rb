#!/usr/bin/env ruby
# frozen_string_literal: true

# loops.rb — iteration patterns: while, until, for, modifiers

# Numeric iterators
5.times { puts 'Test' }
1.upto(5) { |n| puts n }
10.downto(5) { |n| puts n }
0.step(50, 5) { |n| puts n }

# loop do with break
counter = 0
loop do
  puts "Counter is #{counter}"
  break if counter == 5

  counter += 1
end

# while
counter = 0
while counter <= 5
  puts "Counting ...#{counter}"
  break if counter == 5

  counter += 1
end

# until
counter = 0
until counter == 5
  counter += 1
  puts "Counting ...#{counter}"
end

# each over ranges and hashes
nums = Array.new(5) { |n| n * 2 }
nums.each { |n| puts n }

contacts = { carlos: 57, alicia: 54, sergio: 27 }
contacts.each { |key, value| puts "Key #{key} = Value #{value}" }

# each_char
'Carlos'.each_char { |char| puts char }

# While modifier (runs body once, then checks condition)
j = 1
begin
  puts "While modifier: #{j}"
  j += 1
end while j < 3

# Until modifier
j = 1
begin
  puts "Until modifier: #{j}"
  j += 1
end until j > 3

# For loop (prefer .each in practice)
for j in 1..5
  puts "For loop #{j}"
end

# Single-line modifier forms
i = 1
i *= 2 until i > 100
puts i  # => 128

i = 1
i *= 2 while i < 100
puts i  # => 128
