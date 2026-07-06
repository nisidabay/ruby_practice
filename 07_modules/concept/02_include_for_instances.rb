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

# Thinking in Ruby
#
# include turns module methods into instance methods — they become part of
# the object's method resolution order (the "mixin"). This is Ruby's answer
# to multiple inheritance without the diamond problem. Unlike C++ virtual
# inheritance or Python's MRO gymnastics, Ruby's include is straightforward:
# modules go into the ancestor chain, and the last included module wins.
# No class can have multiple parents, but any class can include many modules.
