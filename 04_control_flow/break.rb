#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Break
# This file contains Ruby code for break.

# break - terminates the loop completely

money_setence = 'I love $ in the morning, $ in the afternoon, and $ at night'

current_index = 0
final_index = money_setence.length - 1

while current_index <= final_index
  break if money_setence[current_index] == '$'

  current_index += 1
end
puts current_index
