#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Command-line arguments and input

# --- Print all command-line arguments ---
# Run this as: ruby exercises.rb hello world 42
ARGV.each_with_index do |arg, i|
  puts "ARGV[#{i}] = #{arg}"
end

# --- Sum all numeric arguments ---
# total = ARGV.select { |a| a.match?(/^\d+$/) }.map(&:to_i).sum
# puts "Sum of numbers: #{total}"

# --- Build a simple calculator that takes: operation, num1, num2 ---
# Example: ruby exercises.rb add 5 3 => 8
# op = ARGV[0]
# a = ARGV[1].to_f
# b = ARGV[2].to_f
# case op
# when "add" then puts a + b
# when "sub" then puts a - b
# when "mul" then puts a * b
# when "div" then puts a / b
# else puts "Usage: ruby exercises.rb add|sub|mul|div num1 num2"
# end
