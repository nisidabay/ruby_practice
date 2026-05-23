#!/usr/bin/env ruby
# frozen_string_literal: true

# interpolation.rb — string interpolation with #{} 

x = 10
y = 20
puts "#{x} + #{y} = #{x + y}"

x = 'cat'
puts "The #{x} in the hat"

puts "It's a #{'bad ' * 5}world"
