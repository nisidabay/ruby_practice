#!/usr/bin/env ruby
# frozen_string_literal: true

# if_else.rb

def numeric_energy(value)
  if value > 0
    'Positive'
  elsif value < 0
    'Negative'
  else
    'Zero Hero'
  end
end

puts numeric_energy(5)    # => Positive
puts numeric_energy(-5)   # => Negative
puts numeric_energy(0)    # => Zero Hero
