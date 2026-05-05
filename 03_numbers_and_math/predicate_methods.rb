#!/usr/bin/env ruby
# frozen_string_literal: true

# predicate_methods.rb — boolean query methods on numbers

puts 'odd' if 10.odd?         # nothing
puts 'odd' if 11.odd?         # odd

puts 'even' if 1.even?        # nothing
puts 'even' if 2.even?        # even

puts 'positive' if 10.positive?      # positive
puts 'negative' if (-8).negative?    # negative (need parens on negative literal)
