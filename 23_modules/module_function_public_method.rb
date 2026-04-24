#!/usr/bin/env ruby
# frozen_string_literal: true

# =============================================================================
# PATTERN: extend self vs module_function (Visibility Comparison)
# =============================================================================
# This file demonstrates the KEY DIFFERENCE between `extend self` and
# `module_function` when including/extending modules in classes.
#
# EXTEND SELF:
# - Methods stay PUBLIC when included/extended
# - obj.method() works directly
# - Class.method() works directly
#
# MODULE_FUNCTION:
# - Methods become PRIVATE when included/extended  
# - obj.method() fails (NoMethodError)
# - Class.method() fails (NoMethodError)
# - Must use obj.send(:method) or call internally
#
# Use extend self when: You want public utility methods everywhere
# Use module_function when: You want to hide helper methods from public API
# =============================================================================

module Calculator
  # extend self makes all methods:
  # 1. Available on the module: Calculator.add()
  # 2. PUBLIC when included: obj.add()
  # 3. PUBLIC when extended: Class.add()
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

# Direct calls work (module as toolbox)
Calculator.add(10, 5)       # => 15
Calculator.subtract(10, 5)  # => 5
Calculator.multiply(10, 5)  # => 50

# =============================================================================
# Testing with a class that both includes AND extends
# =============================================================================

# Included methods stay PUBLIC (unlike module_function!)
class MathOperations
  # include gives instance methods (PUBLIC with extend self)
  include Calculator
  
  # extend gives class methods (PUBLIC with extend self)
  extend Calculator
end

# Instance method call - WORKS (public!)
# With module_function, this would fail with NoMethodError
p MathOperations.new.add(10, 5) # => 15 (public!)

# Class method call - WORKS (public!)
# With module_function, this would fail with NoMethodError
p MathOperations.multiply(10, 5) # => 50 (public!)

# =============================================================================
# COMPARISON TABLE
# =============================================================================
# | Pattern       | Module.add | obj.add | Class.add | Use Case          |
# |---------------|------------|---------|-----------|-------------------|
# | extend self   | ✓ Public   | ✓ Public| ✓ Public  | Public utilities  |
# | module_function| ✓ Public  | ✗ Private| ✗ Private| Hidden helpers    |
# =============================================================================
