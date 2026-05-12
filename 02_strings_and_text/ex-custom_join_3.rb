#!/usr/bin/env ruby

# DO NOT USE frozen_string_literal: true
# From Udemy Course

# Define a custom_join method that accepts an array of strings
# and a delimiter. The method should merge/join the array elements
# together into a single string. It should insert the delimiter
# in between every two subsequent elements. Do not use the
# built-in join method in your solution.
#
# Examples:
# The => indicates the expected return value
# custom_join(["red", "green", "blue"], "!") => "red!green!blue"
# custom_join(["Big", "Mac"], "$$")          => "Big$$Mac"
# custom_join([], "$$$")                     => ""
#

def custom_join(str_array, delimiter)
  output = ''
  str_array.each_with_index do |string, index|
    output << delimiter if index > 0
    output << string
  end
  output
end
p custom_join(%w[red green blue blue], '!')
p custom_join(%w[Big Mac], '$$')
p custom_join([], '$$$')
