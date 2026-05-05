#!/usr/bin/env ruby
# frozen_string_literal: true

# hello_lesson.rb — arrays, blocks, string interpolation

guests = %w[Alice Bob Charlie David Eve Frank Grace]

guests.each do |guest|
  puts "Hello, #{guest.upcase}!" if guest.length > 3
  puts "Hello, #{guest}!"
end
