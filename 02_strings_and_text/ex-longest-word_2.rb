#!/usr/bin/env ruby
#
# Define a longest_word method that accepts a string.
# The method should return the longest word in the string.
# If two words are tied for maximum length, the method should
# return the last word in the phrase with that length.
# You can assume:
#  - Every two words are separated by a single space
#  - The string does not contain any symbols or characters
#
# Examples:
# The => indicates the expected return value
# longest_word("Bobby loves big scary kangaroos too")  => "kangaroos"
# longest_word("Ruby is my favorite language")         => "language"
# longest_word("Hello")                                => "Hello"
def longest_word(string)
  words = string.split(' ')
  longest = ''

  words.each do |word|
    if word.length >= longest.length
      longest = word
    end
  end

  longest
end

def longest_word2(string)
  words = string.split(' ')
  longest = words[0]

  words.each do |word|
    if word.length >= longest.length
      longest = word
    end
  end

  longest
end

p longest_word('Bobby loves big scary kangaroos too')
p longest_word('Ruby is my favorite language')
p longest_word('Hello')

p longest_word2('Bobby loves big scary kangaroos too')
p longest_word2('Ruby is my favorite language')
p longest_word2('Hello')
