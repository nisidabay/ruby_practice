#!/usr/bin/env ruby
# frozen_string_literal: true

# ex-longest-word_2.rb — find the longest word in a string
# Tiebreaker: return the LAST word of that length

def longest_word(string)
  string.split(' ').reduce('') { |longest, word| word.length >= longest.length ? word : longest }
end

p longest_word('Bobby loves big scary kangaroos too')  # => kangaroos
p longest_word('Ruby is my favorite language')          # => language
p longest_word('Hello')                                 # => Hello
