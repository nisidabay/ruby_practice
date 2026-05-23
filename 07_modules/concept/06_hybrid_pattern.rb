#!/usr/bin/env ruby
# frozen_string_literal: true

# module_function — public on module, private when mixed into classes

module Calculator
  def add(a, b)
    a + b
  end

  module_function :add
end

puts Calculator.add(10, 5)          # public on module

class MathOperations
  extend Calculator                 # private class methods
  include Calculator                # private instance methods

  def self.class_calc(a, b) = add(a, b)  # internal call works
  def instance_calc(a, b) = add(a, b)    # internal call works
end

puts MathOperations.class_calc(10, 5)         # works
puts MathOperations.new.instance_calc(10, 5)  # works

# MathOperations.add(10, 5)        # private method error
# MathOperations.new.add(10, 5)    # private method error

