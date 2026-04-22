#!/usr/bin/env ruby
# frozen_string_literal: true
#
# String Operations
# This file demonstrates string manipulation techniques.
# Shows interpolation, concatenation, and various string methods.

# Reverse string
# def reverse_string(string)
#   string_length = string.length - 1
#   first_index=0
#   reversed_string=""
#
#   while string_length >= first_index
#     # reversed_string << string[string_length]
#     reversed_string.concat(string[string_length])
#     string_length -=1
#   end
#   reversed_string
# end
#
# puts reverse_string("Carlos")

# def reverse_string(string)
#   reversed = ''
#   string.each_char do |char|
#     reversed = char + reversed
#     puts "Index: #{char}"
#   end
#   reversed
# end

def reverse_string(string)
  (1..string.length).map { |i| string[-i] }.join
end
puts reverse_string('Carlos')
