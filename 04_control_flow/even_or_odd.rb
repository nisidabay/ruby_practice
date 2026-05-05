#!/usr/bin/env ruby
# frozen_string_literal: true

# even_or_odd.rb — ternary with .even?

def transform_number(value)
  value.even? ? value + 2 : value - 3
end

[2, 0, 13, 9].each { |num| puts transform_number(num) }
