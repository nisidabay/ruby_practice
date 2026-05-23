#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to share instance methods across multiple classes.
# Example: All objects that include the module should respond to .add
#
# Solution: Use include to mix in instance methods.
# Visibility: PUBLIC on objects by default.

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
end

class MathOperations
  include Calculator
end

# Usage: Call on instances
obj = MathOperations.new
puts obj.add(10, 5)
puts obj.subtract(10, 5)
puts obj.multiply(10, 5)
