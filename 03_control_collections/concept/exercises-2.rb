#!/usr/bin/env ruby
# frozen_string_literal: true

# Exercise from Udemy Course
# Define a reverse_all method that accepts an array of strings.
# The method should return an array with all the strings in reversed order.
#
# Examples:
# The => indicates the expected return value
# reverse_all(["cat", "bat", "tub"]) => ["tac", "tab", "but"]
# reverse_all(["forest"])            => ["tserof"]
# reverse_all([])                    => []

def reverse_all(str_array)
  str_array.map { |e| e.reverse }
end
p reverse_all(%w[cat bat tub])
p reverse_all(['forest'])
p reverse_all([])

# Define a words_with_letter method that accepts an array of strings and a letter.
# The method should return an array of the strings that include the letter.
#
# Examples:
# The => indicates the expected return value
# words_with_letter(["cat", "bat", "tub"], "a") => ["cat", "bat"]
# words_with_letter(["cat", "bat", "tub"], "u") => ["tub"]
# words_with_letter(["cat", "bat", "tub"], "z") => []

def words_with_letter(str_array, letter)
  str_array.select { |e| e.downcase.include?(letter.downcase) }
end
p words_with_letter(%w[cat bat tub], 'a')
p words_with_letter(%w[cat bat tub], 'u')
p words_with_letter(%w[cat bat tub], 'z')

# Define an evens_and_odds method that accepts an array of numbers.
# The method should segment the array into two arrays.
# The first array should contain the even numbers.
# The second array should contain the odd numbers.
# Return an array consisting of the two arrays.
#
# Examples:
# The => indicates the expected return value
# evens_and_odds([1, 2, 3, 4, 5])   => [[2, 4], [1, 3, 5]]
# evens_and_odds([2, 4, 6, 8])      => [[2, 4, 6, 8],[]]
# evens_and_odds([])                => [[], []]

def evens_and_odds(num_array)
  # even = num_array.select { |e| e.even? }
  # odd = num_array.select { |e| e.odd? }
  # [even, odd]
  num_array.partition { |e| e.even? }
end
p evens_and_odds([1, 2, 3, 4, 5])
p evens_and_odds([2, 4, 6, 8])
p evens_and_odds([])
