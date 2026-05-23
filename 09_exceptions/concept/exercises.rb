#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Bug hunting: find and fix the problems

# --- Bug 1: This should print 0, 1, 2, 3, 4. It doesn't. Fix it. ---
# 5.times do |i|
#   puts i + 1
# end

# --- Bug 2: This method returns nil. It should return the sum. Find why. ---
# def sum(a, b)
#   result = a + b
# end
# puts sum(3, 4)  # Expected: 7

# --- Bug 3: TypeError — can't add string and integer. Fix it. ---
# age = 30
# puts "I am " + age + " years old"

# --- Bug 4: This loop never ends. Add a stop condition. ---
# counter = 0
# loop do
#   puts counter
# end
