#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to add class methods to a class (not instance methods).
# Example: MathOperations.add(5, 3) should work, but MathOperations.new.add should not.
#
# Solution: Use extend to mix in class methods.
# Visibility: PUBLIC on the class itself.

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
  extend Calculator
end

# Usage: Call on the class, not instances
puts MathOperations.add(10, 5)
puts MathOperations.subtract(10, 5)
puts MathOperations.multiply(10, 5)
