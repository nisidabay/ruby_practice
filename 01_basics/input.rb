#!/usr/bin/env ruby
# frozen_string_literal: true

# Input
# This file demonstrates how to get user input in Ruby.

# The print method displays text without adding a newline at the end.
# This keeps the cursor on the same line for user input.
print 'Enter your name: '

# gets reads a line of input from the user.
# .chomp removes the newline character from the end of the input.
name = gets.chomp

# Create a greeting string.
greeting = 'Hello. Good morning '

# Use string interpolation to combine the greeting with the name.
# puts prints the result and adds a newline.
puts "#{greeting}#{name}"