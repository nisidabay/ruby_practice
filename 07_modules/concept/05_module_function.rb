#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want methods public on the module, but PRIVATE when included in
# classes.
# Example: Calculator.add(5, 3) works, but obj.add(5, 3) should fail.
#
# Solution: Use module_function.
# Visibility: PUBLIC on module, PRIVATE when mixed in.

module Calculator
  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end

  def multiply(a, b)
    a * b
  end

  module_function :add       # Makes :add callable on the module, private in mix-ins
  module_function :subtract  # Makes :subtract callable on the module, private in mix-ins
  module_function :multiply  # Makes :multiply callable on the module, private in mix-ins
end

# Works on the module (public API)
puts Calculator.add(10, 5)

# Fails on instances (private helper)
class MathOperations
  include Calculator

  # But we CAN call it internally from other methods
  def calculate(a, b)
    add(a, b) # Works! Internal use is allowed
  end
end

obj = MathOperations.new
puts obj.calculate(10, 5) # Works (internal call)

class Test
  extend Calculator

  def self.calculate(a, b) # Works! Internal use is allowed
    add(a, b)
  end
end

p Test.calculate(10, 5)
