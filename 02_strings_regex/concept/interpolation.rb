#!/usr/bin/env ruby
# frozen_string_literal: true

# interpolation.rb — string interpolation with #{} 

x = 10
y = 20
puts "#{x} + #{y} = #{x + y}"

x = 'cat'
puts "The #{x} in the hat"

puts "It's a #{'bad ' * 5}world"

# Thinking in Ruby
#
# String interpolation (#{}) evaluates arbitrary Ruby expressions inside
# double-quoted strings. Unlike C's printf or Python's f-strings which
# require explicit format specifiers, Ruby just calls .to_s on anything
# between the braces — expressions, arithmetic, even method calls.
