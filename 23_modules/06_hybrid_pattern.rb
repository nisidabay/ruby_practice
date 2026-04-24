#!/usr/bin/env ruby

# Problem: You want a method callable on the module (public),
# but also usable internally in classes (private helper),
# and NOT callable directly on class/instances from outside.
#
# Solution: Use module_function with both include and extend.
# Visibility: PUBLIC on module, PRIVATE in classes (but usable internally).

module Calculator
  def add(a, b)
    a + b
  end

  module_function :add
end

# 1. Module call (public)
puts Calculator.add(10, 5)

# 2. Class and instance can use it internally
class MathOperations
  extend Calculator   # Private class methods
  include Calculator  # Private instance methods

  def self.calculate(a, b)
    add(a, b)  # Works internally
  end

  def calculate(a, b)
    add(a, b)  # Works internally
  end
end

puts MathOperations.calculate(10, 5)      # Works (internal)
puts MathOperations.new.calculate(10, 5)  # Works (internal)

# These fail (external calls to private method):
# MathOperations.add(10, 5)      # NoMethodError
# MathOperations.new.add(10, 5)  # NoMethodError

# This could also be done like this:
# If you want the method to be public everywhere,
# use extend self:
#
# module Calculator
#   extend self
#   def add(a, b)
#     a + b
#   end
# end
#
# MathOperations.add(10, 5)      # Works (public)
# MathOperations.new.add(10, 5)  # Works (public)
