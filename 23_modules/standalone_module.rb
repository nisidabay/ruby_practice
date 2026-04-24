#!/usr/bin/env ruby

# =============================================================================
# PATTERN 1: self. Methods (Module as a Toolbox)
# =============================================================================
# This pattern defines methods with self., making them module-level methods.
# The module acts as a namespace/toolbox - methods are called directly on it.
# 
# Key characteristics:
# - Methods are PUBLIC by default
# - Cannot be included/extended to share behavior
# - Pure namespacing - no mixin capability
# - Simplest approach for utility functions
# =============================================================================

# A module is a "toolbox" for grouping related classes, methods, and constants.
# They provide namespacing to prevent naming conflicts, similar to directories.
# Unlike classes, modules cannot be instantiated (no .new method).

module Calculator
  # self is what allows us to use the module as standalone "toolbox"
  # by exposing those methods directly on the module's name

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

puts Calculator.add(10, 5)
puts Calculator.subtract(10, 5)
puts Calculator.multiply(10, 5)

# =============================================================================
# PATTERN 2: module_function (Hybrid: Public on Module, Private when Mixed)
# =============================================================================
# This reopens the module and converts methods to module_functions.
# 
# Key characteristics:
# - Methods remain PUBLIC when called on the module: Calculator.method()
# - Methods become PRIVATE when included in a class
# - Provides hybrid behavior: toolbox + mixin capability
# - More flexible than self. methods alone
# =============================================================================

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

puts Calculator.add(10, 5)
puts Calculator.subtract(10, 5)
puts Calculator.multiply(10, 5)
