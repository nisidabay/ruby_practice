#!/usr/bin/env ruby
# frozen_string_literal: true

# range.rb — inclusive (..) and exclusive (...) ranges

p (1..10).to_a   # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p (1...10).to_a  # => [1, 2, 3, 4, 5, 6, 7, 8, 9]

p ('a'..'e').to_a   # => ["a", "b", "c", "d", "e"]
p ('a'...'e').to_a  # => ["a", "b", "c", "d"]
