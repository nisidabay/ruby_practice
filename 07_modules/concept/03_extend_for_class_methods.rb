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

# Thinking in Ruby
#
# extend adds module methods as CLASS methods, not instance methods.
# This is the flip side of include: same module, different receiver.
# MathOperations.add(10, 5) works, but MathOperations.new.add does not.
# The distinction between include (instance) and extend (class) is unique to
# Ruby — most languages have only one mechanism for sharing behavior.
