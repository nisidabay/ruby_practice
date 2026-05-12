#!/usr/bin/env ruby
# string_frozen_literal :true

# From Udemy Course

# Define a sum_of_string_lengths method that accepts
# any number of strings. The method return the sum
# of the lengths of the strings.
#
# Examples:
# The => indicates the expected return value
# sum_of_string_lengths("bob", "loves", "burgers")     => 15
# sum_of_string_lengths("coding", "is", "so", "fun")   => 13
# sum_of_string_lengths()                              => 0

# First approach
def sum_of_string_lengths(*strings)
  sum = 0
  strings.each { |e| sum += e.length }
  sum
end

# Second approach
def sum_of_string_lengths(*strings)
  strings.reduce(0) { |sum, str| sum + str.to_s.length }
end

p sum_of_string_lengths('bob', 'loves', 'burgers')
p sum_of_string_lengths('coding', 'is', 'so', 'fun')
p sum_of_string_lengths
