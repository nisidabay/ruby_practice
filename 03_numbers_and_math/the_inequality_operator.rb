#!/usr/bin/env ruby
# frozen_string_literal: true

# the_inequality_operator.rb — != compares values

puts 10 != 5           # => true
puts 10 != 10          # => false

puts 'Hello' != 'Goodbye'   # => true
puts 'Hello' != 'hello'     # => true (case sensitive)
puts 'Hello' != 'Hello'     # => false
puts 5 != '5'               # => true (different types)
