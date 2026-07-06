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

# Thinking in Ruby
#
# until + elsif makes game logic read like natural language.
# Ruby's ternary gracefully handles the final message in one line.
# The interactive loop with gets/print is a direct translation of
# how you'd describe the game to another person — Ruby prioritizes
# human readability over syntactic minimalism.
