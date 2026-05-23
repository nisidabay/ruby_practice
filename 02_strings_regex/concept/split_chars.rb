#!/usr/bin/env ruby
# frozen_string_literal: true

# split_chars.rb — splitting a string into characters

vehicle = 'Spaceship'

p vehicle.split('')       # => ["S", "p", "a", "c", "e", "s", "h", "i", "p"]
p vehicle.chars           # same, more idiomatic

vehicle.each_char { |letter| puts letter }
