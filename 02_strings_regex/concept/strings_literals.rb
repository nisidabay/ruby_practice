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

# Thinking in Ruby
#
# Ruby heredocs (<<~STRIP) and multi-line single quotes give string
# literals the flexibility of here-docs without the ceremony. The squiggly
# heredoc (<<~) auto-strips leading whitespace — a Ruby innovation that
# keeps indented code clean while preserving the string content exactly
# as intended.
