#!/usr/bin/env ruby
# frozen_string_literal: true

# even_or_odd.rb — ternary with .even?

def transform_number(value)
  value.even? ? value + 2 : value - 3
end

[2, 0, 13, 9].each { |num| puts transform_number(num) }

# Thinking in Ruby
#
# The ternary operator (condition ? a : b) returns a value — no statement
# required. Ruby's .even? and .odd? methods on Integer make parity checks
# read naturally. Combined with .each, the entire transformation pipeline
# fits in one chained expression without intermediate variables.
