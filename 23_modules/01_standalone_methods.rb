#!/usr/bin/env ruby

# Problem: You want utility methods that are always called on the module itself.
# Example: Calculator.add(5, 3) - never on an object.
#
# Solution: Use self. to define module-level methods.
# Visibility: PUBLIC on module only.

module Calculator
  def self.add(a, b)
    a + b
  end

  def self.subtract(a, b)
    a - b
  end

  def self.multiply(a, b)
    a * b
  end
end

# Usage: Always call on the module
puts Calculator.add(10, 5)
puts Calculator.subtract(10, 5)
puts Calculator.multiply(10, 5)

# This could also be done like this:
# If you want the same methods available on the module BUT also want to
# include them in classes (as private helpers), use module_function:
#
# module Calculator
#   def add(a, b)
#     a + b
#   end
#   module_function :add
# end
#
# Calculator.add(10, 5)     # Works (public on module)
# obj.add(10, 5)            # Fails (private in classes)
