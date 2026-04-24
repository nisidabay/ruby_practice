#!/usr/bin/env ruby

# Problem: You want methods public on the module, but PRIVATE when included in classes.
# Example: Calculator.add() works, but obj.add() should fail (internal helper only).
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

  module_function :add
  module_function :subtract
  module_function :multiply
end

# Works on the module (public API)
puts Calculator.add(10, 5)

# Fails on instances (private helper)
class MathOperations
  include Calculator

  # But we CAN call it internally from other methods
  def calculate(a, b)
    add(a, b)  # Works! Internal use is allowed
  end
end

obj = MathOperations.new
puts obj.calculate(10, 5)  # Works (internal call)

# This fails (external call to private method):
# obj.add(10, 5)           # NoMethodError!

# This could also be done like this:
# If you want methods to stay PUBLIC when included,
# use extend self instead:
#
# module Calculator
#   extend self
#   def add(a, b)
#     a + b
#   end
# end
#
# Calculator.add(10, 5)     # Works
# obj.add(10, 5)            # Also works (public)
