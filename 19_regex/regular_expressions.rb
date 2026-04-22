#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Regular expressions
# This file contains Ruby code for regular expressions.

# Substitutions
# Only one match
puts 'foobar'.sub('bar', 'foo')

# Global match
puts 'This is a test'.gsub('i', '')

# Replace the first two characters with 'Hello'
x = 'This is a test'
puts x.sub(/^../, 'Hello')

# Replace the last two characters with 'Hello'
x = 'This is a test'
puts x.sub(/..$/, 'Hello')

# Iteration with a regular expression
'xyz'.scan(/./) { |letter| puts letter }

# Scannint two characters
'This is a test scan'.scan(/../) { |chars| puts chars }

# Scanning two alphanumeric characters
'This is a test scan'.scan(/\w\w/) { |letters| puts letters }

Note = %q(If you want to anchor to the absolute start or end of a string, you can use \A and \z, respectively,whereas ^ and $ anchor to the starts and ends of lines within a string.
)
puts Note
puts

x = 'This_is_ a_test'
puts x.sub(/\A/, 'Hello')
puts x.sub(/\z/, 'Hello')

# Extract numbers from string
'The car costs $1000 and the cat costs $10'.scan(/\d+/) do |x|
  puts x
end

# Extract vowels from string
'The car costs $1000 and the cat costs $10'.scan(/[aeiou]/) do |x|
  puts x
end
