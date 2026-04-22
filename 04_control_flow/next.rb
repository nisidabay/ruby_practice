#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Next
# This file contains Ruby code for next.

# next - move automatically to the next iteration of a loop

money_sentence = 'I love $ in the morning, $ in the afternoon, and $ at night'

current_index = 0
final_index = money_sentence.length - 1

while current_index <= final_index
  if money_sentence[current_index] != '$'
    current_index += 1
    next
  end
  puts "Found $ at index: #{current_index}"
  current_index += 1
end
puts money_sentence.gsub('$', 'money')
