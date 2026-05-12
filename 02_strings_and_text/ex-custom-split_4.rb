#!/usr/bin/env ruby
# From Udemy Course
#
# Define a custom_split method that accepts a piece of text and a delimiter.
# The method should return an array of the segments of the text
# after being split by the delimiter. Your solution should NOT
# use the built-in split method on a string. Assume that the delimiter
# will never be an empty string.
#
# Examples:
# The => indicates the expected return value
# custom_split("Hi, my name is Boris", " ")  => ["Hi,", "my", "name", "is", "Boris"]
# custom_split("ravioli is delicious", "i")  => ["rav", "ol", " ", "s del", "c", "ous"]
# custom_split("Zebra", "j")                 => ["Zebra"]
# custom_split(" hello", " ")                => ["hello"]
def custom_split(string, delimiter)
  result = []
  start = 0
  raise ArgumentError if delimiter.empty?

  # Loop as long as we can find the delimiter in the remaining string
  while (match_index = string.index(delimiter, start))
    # If the delimiter is found, slice the text from 'start' up to the delimiter
    segment = string[start, match_index - start]
    result << segment unless segment.empty?

    # Move our starting point past the delimiter
    start = match_index + delimiter.length
  end

  # After the loop ends, grab whatever text is left over at the end
  remaining = string[start..]
  result << remaining unless remaining.empty?

  result
end

p custom_split('Hi, my name is Boris', ' ') # => ["Hi,", "my", "name", "is", "Boris"]
p custom_split('ravioli is delicious', 'i')     # => ["rav", "ol", " ", "s del", "c", "ous"]
p custom_split('Zebra', 'j')                    # => ["Zebra"]
p custom_split(' hello', ' ')                   # => ["hello"]

# Now it also handles multi-character delimiters!
p custom_split('apple--banana--cherry', '--') # => ["apple", "banana", "cherry"]
