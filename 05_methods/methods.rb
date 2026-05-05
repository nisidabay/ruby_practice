#!/usr/bin/env ruby
# frozen_string_literal: true

# methods.rb — method definitions: splat, defaults

def undefined_parameters(*data)
  puts "Number of parameters: #{data.length}"
  data.each_with_index { |d, i| puts "Parameter [#{i}] = #{d}" }
end

undefined_parameters 'carlos', 57, 'male'

def default_parameters(name = 'Carlos', age = 57)
  puts "#{name}, #{age}"
end

default_parameters
default_parameters 'Peter', 45
