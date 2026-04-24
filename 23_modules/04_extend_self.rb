#!/usr/bin/env ruby

# Problem: You want a module that works as a standalone toolbox,
# but you also want to include it in classes and keep methods PUBLIC.
#
# Solution: Use extend self.
# Visibility: PUBLIC everywhere (module, instances, classes).

module Calculator
  extend self

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

# Works on the module
puts Calculator.add(10, 5)

# Works when included (methods stay public)
class MathOperations
  include Calculator
end

obj = MathOperations.new
puts obj.add(10, 5)

# Works when extended (methods stay public)
class AnotherClass
  extend Calculator
end

puts AnotherClass.subtract(10, 5)

# This could also be done like this:
# If you want methods to become PRIVATE when included/extended,
# use module_function instead:
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
# Calculator.add(10, 5)       # Works (public on module)
# obj = MathOperations.new
# obj.add(10, 5)              # Fails (private in classes)
