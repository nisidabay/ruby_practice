#!/usr/bin/env ruby
# frozen_string_literal: true

# Push
# This file contains Ruby code for push.

# The << (shovel) operator in Ruby appends an element to the end of an array

# Starting with an empty array
names = []
names << 'Mark'
names << 'Laura'
names << 'Buddy'
names << 'Patrick'

puts names # ["Mark", "Laura", "Buddy", "Patrick"]

# Can append different data types
mixed = []
mixed << 'string'
mixed << 42
mixed << true
mixed << nil

puts mixed # ["string", 42, true, nil]

# Chaining multiple appends
colors = []
colors << 'red' << 'green' << 'blue'

puts colors # ["red", "green", "blue"]

# Appending to existing array
names << 'Willy the cat'
ages = [49, 48, 17, 14]
ages << 6

puts names  # ["Mark", "Laura", "Buddy", "Patrick", "Willy the cat"]
puts ages   # [49, 48, 17, 14, 6]

# Appending arrays (creates nested array)
queue = [1, 2]
queue << [3, 4]
puts queue # [1, 2, [3, 4]]
