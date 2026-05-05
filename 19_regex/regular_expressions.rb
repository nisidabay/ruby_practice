#!/usr/bin/env ruby
# frozen_string_literal: true

# regular_expressions.rb — sub, gsub, scan, anchors

# sub: first match only, gsub: all matches
puts 'foobar'.sub('bar', 'foo')            # => foofoo
puts 'This is a test'.gsub('i', '')        # => Ths s a test

# Anchors: ^ and $
puts 'This is a test'.sub(/^../, 'Hello')  # => Hellois is a test
puts 'This is a test'.sub(/..$/, 'Hello')  # => This is a teHello

# scan: iterate over matches
'xyz'.scan(/./) { |letter| puts letter }
'This test scan'.scan(/\w\w/) { |chars| puts chars }

# \A and \z anchor to absolute string start/end (not line start/end)
x = 'This_is_a_test'
puts x.sub(/\A/, 'Hello')   # => HelloThis_is_a_test
puts x.sub(/\z/, 'Hello')   # => This_is_a_testHello

# Extract data with scan
'The car costs $1000 and the cat costs $10'.scan(/\d+/) { |x| puts x }
'The car costs $1000 and the cat costs $10'.scan(/[aeiou]/) { |x| puts x }

