#!/usr/bin/env ruby

# =============================================================================
# PATTERN: extend self (Module as Toolbox + Mixin for Class Methods)
# =============================================================================
# This pattern uses `extend self` to make all module methods available as:
# 1. Module-level methods (toolbox pattern)
# 2. Instance methods when included (but they stay public!)
# 3. Class methods when extended
#
# Key characteristics:
# - `extend self` extends the module with itself
# - All methods become module-level (callable as Module.method)
# - Methods remain PUBLIC when mixed into classes
# - Cleaner than defining each method with self.
# - Provides "multiple inheritance" for classes
#
# Comparison with other patterns:
# | Pattern          | Module.method | obj.method | Visibility |
# |------------------|---------------|------------|------------|
# | self. methods    | YES           | N/A        | Public     |
# | extend self      | YES           | YES (inc)  | Public     |
# | module_function  | YES           | YES (priv) | Mixed      |
# =============================================================================

module Calculator
  # This makes the methods available to the module itself
  # by extending the module with its own instance methods
  # 
  # Equivalent to writing:
  #   def self.add(a, b) ... end
  #   def self.subtract(a, b) ... end
  #   def self.multiply(a, b) ... end
  #
  # But cleaner and more maintainable!
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

# And you can also call it like a class
# Methods are public on the module
puts Calculator.add(10, 5)
puts Calculator.subtract(10, 5)
puts Calculator.multiply(10, 5)

# But we can use to provide "multiple inheritance in classes"
# When a class extends a module, it gains the module's methods as CLASS methods
class MathOperations
  extend Calculator
end

# Now MathOperations can call these methods at the class level
# (not on instances - those would need `include` instead of `extend`)
p MathOperations.add(10, 5)
