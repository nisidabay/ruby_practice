#!/usr/bin/env ruby
# frozen_string_literal: true

# Number Guessing Game
# This file implements a simple number guessing game.
# Demonstrates user input handling and basic game logic.

puts "Welcome to 'Get My Number!'"

print "What's your name? "
input = gets
name = input&.chomp || 'Player'
puts "Welcome, #{name}"

puts "I've got a random number between 1 and 100."
puts 'Can you guess it?'
target = rand(1..101)

num_guesses = 0
guess_it = false

until num_guesses == 10 || guess_it
  puts "You've got #{10 - num_guesses} guesses left"
  print 'Make a guess: '
  guess = gets.to_i

  num_guesses += 1
  if guess < target
    puts 'Oops. Your guess was LOW'
  elsif guess > target
    puts 'Oops. Your guess was HIGH'
  elsif guess == target
    puts "Good job, #{name}!"
    puts "You guessed my number in #{num_guesses} guesses!"
    guess_it = true
  end
end

puts "Sorry. You didn't get my number. (It was #{target}.)" unless guess_it
