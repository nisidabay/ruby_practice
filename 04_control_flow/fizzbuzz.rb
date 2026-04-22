#!/usr/bin/env ruby
# frozen_string_literal: true
#
# FizzBuzz Implementation
# Classic FizzBuzz exercise - prints numbers from 1 to n, replacing multiples of 3 with "Fizz",
# multiples of 5 with "Buzz", and multiples of both with "FizzBuzz".

# FizzBuzz exercise
def fizzbuzz(number)
  counter = 1

  while counter <= number
    if counter % 3 == 0 && counter % 5 == 0
      puts 'FizzBuzz'
    elsif counter % 3 == 0
      puts 'Fizz'
    elsif counter % 5 == 0
      puts 'Buzz'
    else
      puts counter
    end
    counter += 1
  end
end

fizzbuzz(30)
