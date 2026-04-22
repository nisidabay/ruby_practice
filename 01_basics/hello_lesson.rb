#!/usr/bin/env ruby
# frozen_string_literal: true

# Hello Lesson
# This file demonstrates arrays, loops, and string interpolation in Ruby.

# Create an array of guest names using %w[] syntax (word array).
# This is a shorthand that creates an array of strings without quotes.
guests = %w[Alice Bob Charlie David Eve Frank Grace]

# Iterate through each guest in the array using the .each method.
# The code between 'do' and 'end' is called a block.
guests.each do |guest|
  # Condition: only print uppercase greeting if name is longer than 3 characters.
  # #{...} is string interpolation - it embeds Ruby expressions inside strings.
  puts "Hello, #{guest.upcase}!" if guest.length > 3

  # Print a normal greeting for every guest.
  puts "Hello, #{guest}!"
end

