#!/usr/bin/env ruby

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

# This could also be done like this:
# If you want the methods to be PRIVATE in the including class
# (so they can only be called internally, not from outside),
# use module_function:
#
# module Calculator
#   def add(a, b)
#     a + b
#   end
#   module_function :add
# end
#
# class MathOperations
#   include Calculator
# end
#
# obj = MathOperations.new
# obj.add(10, 5)              # Fails! (private)
# obj.send(:add, 10, 5)       # Works (forced access)
