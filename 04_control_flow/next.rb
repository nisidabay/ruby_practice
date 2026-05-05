#!/usr/bin/env ruby
# frozen_string_literal: true

# next.rb — skip to next iteration with next

sentence = 'I love $ in the morning, $ in the afternoon, and $ at night'

i = 0
while i < sentence.length
  if sentence[i] != '$'
    i += 1
    next
  end
  puts "Found $ at index: #{i}"
  i += 1
end
