#!/usr/bin/env ruby
# frozen_string_literal: true

# matching.rb — regex matching with =~ 

puts 'String has vowels' if 'This is a test' =~ /[aeiou]/

# Thinking in Ruby
#
# Ruby's =~ operator returns the match position (truthy) or nil — making
# it work directly in if conditions without casting. The regex literal /.../
# is a first-class expression, not a string compiled behind the scenes.
# This integration of regex into the language syntax is uniquely Ruby.
