#!/usr/bin/env ruby
# frozen_string_literal: true

# while.rb — loop while a condition holds

# WITHOUT while — you'd use a counter + if + break manually:
#
#   i = 0
#   loop do
#     break if i >= 5
#     puts "Attempt #{i}"
#     i += 1
#   end
#   # 4 lines of ceremony for "repeat N times"
#
# WITH while — condition is at the top, no break ceremony:

attempt = 0
while attempt < 3
  puts "Attempt #{attempt + 1} — connecting..."
  attempt += 1
end
# exits cleanly when attempt reaches 3

# Thinking in Ruby
#
# Ruby's while is an expression too — if the body is a single statement,
# you can write it inline: `i += 1 while i < 3`. While loops are less
# common than .each in idiomatic Ruby, but they remain essential when the
# termination condition is checked before every iteration (e.g. retry
# loops).
