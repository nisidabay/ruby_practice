#!/usr/bin/env ruby
# frozen_string_literal: true

# push.rb — appending to arrays with << and push

names = []
names << 'Mark' << 'Laura' << 'Buddy'
p names  # => ["Mark", "Laura", "Buddy"]

# Mixed types
mixed = []
mixed << 'string' << 42 << true << nil
p mixed  # => ["string", 42, true, nil]

# push adds elements to end (<< is syntactic sugar for push)
ages = [49, 48]
ages.push(17, 14)     # push multiple
ages << 6
p ages  # => [49, 48, 17, 14, 6]

# Appending an array nests it (use concat or + for flat merge)
queue = [1, 2]
queue << [3, 4]
p queue  # => [1, 2, [3, 4]]
queue.flatten!  # => [1, 2, 3, 4]


# Thinking in Ruby
#
# The << (shovel) operator is Ruby's idiomatic append — it reads as "push
# into" and chains naturally. Combined with the fact that Array is
# untyped in Ruby (mixing strings, integers, nils in one array is
# normal), << is used everywhere from collections to string building.
