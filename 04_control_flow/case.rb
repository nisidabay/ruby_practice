#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Case
# This file contains Ruby code for case.

# Use of case

def check_score(score)
  case score
  when 0..4
    puts '👇Failed'
  when 5
    puts '👌Passed'
  else
    puts '💯Good mark!'
  end
end

check_score(7)

status = 200

case status
when 200
  puts 'OK'
when 404
  puts 'Not Found'
else
  puts 'Unknown Status'
end

input = 'Hello World'

case input
when String
  puts "Received a string: #{input.capitalize}"
when Integer
  puts "Received a number: #{input + 1}"
when Array
  puts "Received an array with #{input.size} items"
end

email = 'user@example.com'

case email
when /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  puts 'Valid email format'
else
  puts 'Invalid email'
end

character = 'a'

case character
when 'a', 'e', 'i', 'o', 'u'
  puts 'Vowel'
when 'b'..'z'
  puts 'Consonant'
end

value = 42 # Define a value to test

type = case value
       when Integer then 'Number'
       when String  then 'Text'
       else 'Unknown'
       end

puts type
