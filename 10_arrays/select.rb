#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Select
# This file contains Ruby code for select.

# select - filter array for elements that satisfy a condition
# reject - filer array for elements that do not satisfy a condition

words = %w[racecar selfless sentences level]
palindrome = words.select { |word| word == word.reverse }
p palindrome

animals = %w[cheetah, cat lion elephant dog cow]
p(animals.reject { |animal| animal.include?('c') })
