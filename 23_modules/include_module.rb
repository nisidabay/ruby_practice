#!/usr/bin/env ruby

# =============================================================================
# PATTERN: module_function with include (Private Instance Methods)
# =============================================================================
# This demonstrates how module_function affects method visibility when
# a module is included in a class.
#
# Key characteristics:
# - Methods are PUBLIC on the module: Calculator.add()
# - Methods become PRIVATE in including classes: obj.add() fails
# - Private methods can still be called internally by other public methods
# - Useful for helper methods that should only be used internally
#
# Visibility table:
# | Call Site                    | Visibility | Works? |
# |------------------------------|------------|--------|
# | Calculator.method()          | Public     | YES    |
# | obj.method()                 | Private    | NO     |
# | obj.other_method() → method  | Internal   | YES    |
# | obj.send(:method)            | Forced     | YES    |
# =============================================================================

module Calculator
  # Instance method definition (no self.)
  # Will be available to classes that include this module
  def add(a, b)
    a + b
  end

  # Instance method that can call other module methods internally
  # This works because add is accessible within the instance context
  def subtract(a, b)
    a - b
  end

  # Instance method
  def multiply(a, b)
    a * b
  end

  # The module ONLY exposes these methods.
  # For any class that includes this module, these methods become PRIVATE.
  # 
  # IMPORTANT: Only add and subtract are marked as module_function!
  # - multiply remains PUBLIC when included
  # - This creates mixed visibility within the same module
  module_function :add
  module_function :subtract
end

# Class includes the module, gaining instance methods
class MathOperations
  include Calculator
end

# 1. Test Object public access
# multiply is PUBLIC (not marked with module_function)
# So we can call it directly on instances
mo = MathOperations.new
puts "Object multiply: #{mo.multiply(10, 5)}"

# 2. Test Module public exposure
# add and subtract are PUBLIC on the module itself (module_function behavior)
puts "Module add: #{Calculator.add(10, 5)}"
puts "Module subtract: #{Calculator.subtract(10, 5)}"

# 3. Test Object private access (will fail)
# add is PRIVATE on instances due to module_function
# Direct calls fail with NoMethodError
begin
  obj = MathOperations.new
  puts "Object add: #{obj.add(10, 5)}"
rescue NoMethodError
  puts 'ERROR: Object cannot call .add because it is private!'
end
