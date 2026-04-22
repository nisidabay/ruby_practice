#!/usr/bin/env ruby
# frozen_string_literal: true

# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including classes and modules.
# Shows inheritance, polymorphism, and encapsulation.

# Looping

# Using times
5.times { puts 'Test' }
puts

1.upto(5) { |number| puts number }
puts

10.downto(5) { |number| puts number }
puts

0.step(50, 5) { |number| puts number }
puts
#
# You can spread the code multiple lines
1.upto(5) do |number|
  puts number
end

# Using loop
number = 100
counter = 0
loop do
  puts "Counter is #{counter}"
  if counter == number
    puts 'Boom! from loop do'
    break
  end

  counter += 1
end

# Using while
number = 100
counter = 0
while counter <= number
  puts "Counting ...#{counter}"
  if counter == number
    puts 'Boom! from while'
    break
  end
  counter += 1
end

# Using until
number = 100
counter = 0
until counter == number
  counter += 1
  puts "Counting ...#{counter}"
end
puts 'Boom! from until'

# Using each
nums = Array.new(10) { |n| n * 2 }
nums.each do |n|
  puts n
end

contacts = { carlos: 57, alicia: 54, sergio: 27, clara: 22, dani: 19 }
contacts.each do |key, value|
  puts "Key #{key} = Value #{value}"
end

'Carlos'.each_char do |char|
  puts char
end

# While modifier
# $ means global variable
$j = 1
$n = 5
begin
  puts("While modifier statement number #{$j}")
  $j += 1
end while $j < $n

# Until modifier
# $ means global variable
$j = 1
$n = 5
begin
  puts("Until modifier statement number #{$j}")
  $j += 1
end until $j > $n

# For statement
for j in 1..10
  puts "This is a for loop number #{j}"
end

# Iterator similar to for loop
(1..10).each do |n|
  puts "Iterator as for loop #{n}"
end

# Using until in a single line
puts 'Using until in a single line'
i = 1
i *= 2 until i > 100
puts i

# Using while in a single line
puts 'Using while in a single line'
i = 1
i *= 2 while i < 100
puts i
