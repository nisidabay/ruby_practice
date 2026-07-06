#!/usr/bin/env ruby
# frozen_string_literal: true

# Iteration with loops

animals = %w[Leon Zebra Cheetah Baboon]

# 1. while loop
i = 0
while i < animals.length
  p "animal at index #{i} is: #{animals[i]}"
  i += 1
end

puts

# 2. until loop
x = 0
until x == animals.length
  p animals[x]
  x += 1
end

puts

# 3. for loop
for animal in animals
  p animal
end

puts

# 4. loop (infinite loop with break)
y = 0
loop do
  break if y == animals.length

  p animals[y]
  y += 1
end

puts

# 5. times loop
animals.length.times do |idx|
  p "animal at index #{idx} is: #{animals[idx]}"
end

puts

# 6. upto loop
0.upto(animals.length - 1) do |idx|
  p animals[idx]
end

puts

# 7. downto loop
(animals.length - 1).downto(0) do |idx|
  p animals[idx]
end

puts

z = 0
begin
  p animals[z]
  z += 1
end while z < animals.length

puts

# 9. begin...until (do-until)
w = 0
begin
  p animals[w]
  w += 1
end until w == animals.length

# Thinking in Ruby
#
# This file demonstrates 9 ways to iterate an array — while, until, for,
# loop, times, upto, downto, begin...while, begin...until. While .each
# is the idiomatic choice, knowing the full spectrum lets you read legacy
# code and choose the right tool when .each doesn't fit (e.g. unbounded
# iteration, conditional termination).
