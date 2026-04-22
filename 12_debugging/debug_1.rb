#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Debug 1
# This file contains Ruby code for debug 1.

# binding.break is the as writting "debugger"
# to go to the next debugger point write "continue"
# "step" goes to the next line
# "info" shows variables
require 'debug'

candy = 'Sour Patch Kids'
puts "I love eating #{candy}"

binding.break

beverage = 'Fresh-iced water'
puts "I love drinking #{beverage}"

debugger

3.times do |count|
  puts "On loop number: #{count}"
  puts 'text'
end
