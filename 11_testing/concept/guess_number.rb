#!/usr/bin/env ruby
# frozen_string_literal: true

# guess_number.rb — rand, gets, loops, and conditional branching

target = rand(1..100)
guess = nil
attempts = 0

until guess == target || attempts >= 10
  print "Guess (1-100): "
  guess = gets.to_i
  attempts += 1

  if guess < target
    puts "Higher. #{10 - attempts} left."
  elsif guess > target
    puts "Lower. #{10 - attempts} left."
  end
end

puts guess == target ? "Got it in #{attempts}!" : "It was #{target}."
