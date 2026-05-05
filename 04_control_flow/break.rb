#!/usr/bin/env ruby
# frozen_string_literal: true

# break.rb — break exits a loop immediately

sentence = 'I love $ in the morning, $ in the afternoon, and $ at night'

i = 0
while i < sentence.length
  break if sentence[i] == '$'

  i += 1
end
puts i  # => 7 (index of first $)
