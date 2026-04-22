#!/usr/bin/env ruby
# frozen_string_literal: true

# If else
# This file contains Ruby code for if else.

def numeric_energy(value)
  if value > 0
    'Positive'
  elsif value < 0
    'Negative'
  else
    'Zero Hero'
  end
end

puts numeric_energy(5)
puts numeric_energy(10)
puts numeric_energy(-5)
puts numeric_energy(-8)
puts numeric_energy(0)
