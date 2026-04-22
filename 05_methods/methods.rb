#!/usr/bin/env ruby
# frozen_string_literal: true

# Method Examples
# This file demonstrates Ruby method definitions and usage.
# Shows parameter handling, blocks, and method chaining.

# Undefined number of parameters
def undefined_parameters(*testdata)
  puts "Number of parameters: #{testdata.length}"
  for n in 0..testdata.length - 1
    puts "Parameter [#{n}] = #{testdata[n]}"
  end
end

undefined_parameters 'carlos', 57, 'male'

# Default parameters
def default_parameters(name = 'Carlos', age = 57)
  puts "#{name}, #{age}"
end

default_parameters
default_parameters 'Peter', 45
