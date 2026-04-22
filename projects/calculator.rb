#!/usr/bin/env ruby
# frozen_string_literal: true
# Simple Calculator
# This file implements basic arithmetic operations.
# Demonstrates method definitions and mathematical operations.


# Ruby - calculator

puts '--- Simple Ruby Calculator ---'

print 'Enter first number: '
num1 = gets.chomp.to_f

print 'Enter operator (+, -, *, /): '
operator = gets.chomp

print 'Enter second number: '
num2 = gets.chomp.to_f

result = case operator
         when '+' then num1 + num2
         when '-' then num1 - num2
         when '*' then num1 * num2
         when '/' then num2.zero? ? 'Error: Division by zero' : num1 / num2
         else 'Invalid operator'
         end

puts "Result: #{result}"
