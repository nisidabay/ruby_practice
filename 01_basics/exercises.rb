#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Practice puts, gets, and variables

print "What's your city? "
city = gets.chomp
year = Time.now.year

puts "You're in #{city} in #{year}."

name = 'Carlos'
puts "Hello #{name}"

print "What's your age? "
age = gets.chomp
puts "You're #{age} years old"

puts "Line1\nLine2"
