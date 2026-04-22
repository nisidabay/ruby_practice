#!/usr/bin/env ruby
# Palindrome Checker
# This file checks if a word or phrase is a palindrome.
# Demonstrates string manipulation and comparison techniques.

# frozen_string_literal: true

# !/usr/bin/env ruby
def is_palindrome?(word)
  raise ArgumentError, 'Input must be a String' unless word.is_a?(String)

  cleaned_word = word.downcase.gsub(/[^a-z]/, '')
  cleaned_word == cleaned_word.reverse
end

# Test cases
puts is_palindrome?('racecar')
puts is_palindrome?('Racecar')
puts is_palindrome?('carlos')
puts is_palindrome?('A man, a plan, a canal: Panama')
puts is_palindrome?("No 'x' in Nixon")
puts is_palindrome?('')
begin
  puts is_palindrome?(12_321)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end
