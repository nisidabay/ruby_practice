#!/usr/bin/env ruby
# frozen_string_literal: true

# fizzbuzz.rb

def fizzbuzz(n)
  (1..n).each do |i|
    if i % 15 == 0
      puts 'FizzBuzz'
    elsif i % 3 == 0
      puts 'Fizz'
    elsif i % 5 == 0
      puts 'Buzz'
    else
      puts i
    end
  end
end

fizzbuzz(30)

# Thinking in Ruby
#
# FizzBuzz in Ruby shows if/elsif cascading inside .each — combining
# iteration and conditional logic in one block. The modulo-based divisibility
# check is idiomatic Ruby: (i % 15 == 0) catches multiples of both 3 and 5
# before checking individual cases, eliminating a nested condition.
