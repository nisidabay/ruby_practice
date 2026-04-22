#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Number Guessing Game
# This file implements a simple number guessing game.
# Demonstrates user input handling and basic game logic.

# Ruby - Guessing game

puts 'Welcome to the Number Guessing Game!'
secret_number = rand(1..100)
attempts = 0
top = 10

loop do
  print 'Guess a number between 1 and 100: '
  guess = gets.chomp.to_i
  attempts += 1

  if guess == secret_number
    puts "Congratulations! You guessed it in #{attempts} attempts."
    break
  elsif guess < secret_number
    puts 'Too low! Try again.'
  else
    puts 'Too high! Try again.'
  end

  if attempts == top
    puts "You didn't make it"
    puts "Secret number was:#{secret_number}"
    break
  else
    puts "Remaining chances: #{top - attempts}"
  end
end
