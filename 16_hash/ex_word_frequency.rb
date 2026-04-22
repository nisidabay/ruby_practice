#!/usr/bin/env ruby
# Define a word_frequency method that accepts a piece of text.
# Return a hash with a count of the number of times each word
# appears within the text. The hash keys should be the words
# and the values should be their counts. Assume the text will
# be in all lowercase.
#
# Examples:
# The => indicates the expected return value
# word_frequency("blue red blue green")  => {"blue"=>2, "red"=>1, "green"=>1}
# word_frequency("a land far far away")  => {"a"=>1, "land"=>1, "far"=>2, "away"=>1}
# word_frequency("")                     => {}

def word_frequency(text)
  words = text.split
  word_counter = Hash.new(0)

  words.each { |value| word_counter[value] += 1 }
  word_counter
end
p word_frequency('blue red blue green')
p word_frequency('a land far far away')
p word_frequency('')
