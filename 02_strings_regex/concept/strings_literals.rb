#!/usr/bin/env ruby
# frozen_string_literal: true

# strings_literals.rb — multi-line strings and heredocs

x = 'This is a test
of the multi
line capabilities'
puts x

y = <<~END_MY_STRING
  This is the string
  And a second line
END_MY_STRING
puts y
