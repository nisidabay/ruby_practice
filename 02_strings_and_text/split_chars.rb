#!/usr/bin/env ruby

# What it does: Splits the string into an array using an empty string as the
# delimiter.
vehicle = 'Spaceship'
characters = vehicle.split('')
p characters

# What it does: Explicitly converts the string into an array of its characters.
p vehicle.chars

# What it does: Print individual characters

vehicle.each_char { |letter| p "#{letter}" }
