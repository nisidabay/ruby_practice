#!/usr/bin/env ruby
# frozen_string_literal: true

# palindrome.rb — string equality after cleanup: gsub + reverse

def palindrome?(str)
  cleaned = str.downcase.gsub(/[^a-z]/, '')
  cleaned == cleaned.reverse
end

puts palindrome?('racecar')                           # => true
puts palindrome?('A man, a plan, a canal: Panama')    # => true
puts palindrome?('deploy')                            # => false

# Thinking in Ruby
#
# Ruby's chaining style transforms palindrome detection into a
# one-liner: downcase + gsub + reverse + equality. Each method returns
# a string, so the pipeline reads left-to-right like a sentence.
# This composability is central to Ruby's expressive design — clean
# data transformations without intermediate variables.
