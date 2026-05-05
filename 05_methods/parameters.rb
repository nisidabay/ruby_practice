#!/usr/bin/env ruby
# frozen_string_literal: true

# parameters.rb — splat operator for variadic methods

def sampledata(*data)
  puts "The number of parameters is #{data.length}"
  data.each_with_index { |d, i| puts "Parameter [#{i}] = #{d}" }
end

sampledata('Carlos', 57, 'M')
