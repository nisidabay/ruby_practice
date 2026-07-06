#!/usr/bin/env ruby
# frozen_string_literal: true

# to_s_method_computer.rb — custom string representation

class Computer
  def initialize(cpu = 'Intel i7', memory = 64, storage = '2 TB')
    @cpu = cpu
    @memory = memory
    @storage = storage
  end

  def to_s
    "A #{@cpu} computer with #{@memory}GB RAM, #{@storage} storage"
  end
end

puts Computer.new
puts Computer.new('M3', 32, '1 TB')


# Thinking in Ruby
#
# Overriding to_s customizes string representation — Ruby uses this
# method for interpolation ("#{}"), puts, and string concatenation.
# Default to_s shows the class name and object ID; a custom to_s makes
# objects self-documenting when printed. Default parameter values (cpu =
# 'Intel i7') also show Ruby's flexible constructor patterns.
