#!/usr/bin/env ruby
# frozen_string_literal: true

# case.rb — case/when for multi-way branching

def check_score(score)
  case score
  when 0..4 then puts '👇 Failed'
  when 5    then puts '👌 Passed'
  else           puts '💯 Good mark!'
  end
end

check_score(7)

# With types
input = 'Hello World'
case input
when String  then puts "Got a string: #{input.capitalize}"
when Integer then puts "Got a number: #{input + 1}"
when Array   then puts "Got an array with #{input.size} items"
end

# With regex
email = 'user@example.com'
case email
when /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  puts 'Valid email format'
else
  puts 'Invalid email'
end

# Multiple values
character = 'a'
case character
when 'a', 'e', 'i', 'o', 'u' then puts 'Vowel'
when 'b'..'z'                then puts 'Consonant'
end

# Case returns a value
value = 42
type = case value
       when Integer then 'Number'
       when String  then 'Text'
       else 'Unknown'
       end
puts type # => Number
