#!/usr/bin/env ruby
# frozen_string_literal: true

# include.rb — checking if a string contains a substring

puts 'Big Mac'.include?('B')   # => true
puts 'Big Mac'.include?('Bi')  # => true
puts 'Big Mac'.include?('M')   # => true
puts 'Big Mac'.include?('z')   # => false
puts 'Big Mac'.include?('b')   # => false (case-sensitive)
