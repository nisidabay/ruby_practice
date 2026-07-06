#!/usr/bin/env ruby
# frozen_string_literal: true

# split_chars.rb — splitting a string into characters

vehicle = 'Spaceship'

p vehicle.split('')       # => ["S", "p", "a", "c", "e", "s", "h", "i", "p"]
p vehicle.chars           # same, more idiomatic

vehicle.each_char { |letter| puts letter }

# Thinking in Ruby
#
# Ruby gives strings first-class character iteration with #chars and
# #each_char. Where other languages require explicit type conversions
# (string → char[]), Ruby lets you split, iterate, or index strings with
# the same methods you use on arrays — consistent Enumerable design.
