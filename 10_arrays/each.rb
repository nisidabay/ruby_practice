#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Each
# This file contains Ruby code for each.

# each in Ruby iterates over each element in an array or other enumerable
# object, executing a block of code for each element.

names = %w[Alice Bob Charlie]
names.each do |name|
  puts "Hello, #{name}!" if name.length > 3
end

puts '-'

# Short version
names.each { |name| puts "Hello, #{name}!" if name.length > 3 }
