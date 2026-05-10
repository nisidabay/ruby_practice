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
