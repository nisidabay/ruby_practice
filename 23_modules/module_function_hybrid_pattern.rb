#!/usr/bin/env ruby
# frozen_string_literal: true

# =============================================================================
# PATTERN: module_function Hybrid (Three-Way Access Pattern)
# =============================================================================
# This demonstrates the most powerful module pattern: using module_function
# to achieve THREE different access levels from a single method definition.
#
# GOAL: Make a method callable in THREE ways:
# 1. Directly on the module:        Calculator.add(10,5)     ✓ Public
# 2. Inside class methods:          MyCalc.calculate(10,5)   ✓ Private (internal)
# 3. Inside instance methods:       MyCalc.new.calculate()   ✓ Private (internal)
#
# BUT NOT directly accessible:
# - MyCalc.add(10,5)                ✗ NoMethodError (private)
# - MyCalc.new.add(10,5)            ✗ NoMethodError (private)
#
# KEY INSIGHT: module_function creates a "hybrid" visibility:
# - PUBLIC on the module itself (toolbox pattern)
# - PRIVATE when mixed into classes (hidden helper pattern)
#
# USE CASES:
# - Utility methods you want to expose on the module
# - But keep private when used as mixins (internal helpers)
# - Perfect for validation, conversion, calculation helpers
# =============================================================================

module Calculator
  # Define instance method normally (no self.)
  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end

  def multiply(a, b)
    a * b
  end

  # This makes 'add' available directly on the module (PUBLIC),
  # AND makes it private when included or extended elsewhere (PRIVATE).
  #
  # This is the KEY to the hybrid pattern!
  module_function :add
  # Note: subtract and multiply remain PUBLIC when included/extended
end

# =============================================================================
# Access Level 1: Module-level call (PUBLIC)
# =============================================================================
puts "Module add: #{Calculator.add(10, 5)}"

# =============================================================================
# Access Levels 2 & 3: Class and Instance calls (PRIVATE but usable internally)
# =============================================================================

class MathOperations
  # Adds module methods to the Class level (as private methods)
  # Now MathOperations can call add() internally in its class methods
  extend Calculator

  # Adds module methods to the Instance level (as private methods)
  # Now instances can call add() internally in their instance methods
  include Calculator

  # Class method testing the extended module
  # add() is private, but we can call it from within the class context
  def self.calculate(a, b)
    # We can call add() here because it's available privately to the class
    # This is like calling a private helper method
    add(a, b)
  end

  # Instance method testing the included module
  # add() is private, but we can call it from within the instance context
  def calculate(a, b)
    # We can call add() here because it's available privately to the instance
    # This is like calling a private helper method
    add(a, b)
  end
end

# =============================================================================
# Access Level 2: Class method calling private module method internally
# =============================================================================
puts "Class call: #{MathOperations.calculate(10, 5)}"

# =============================================================================
# Access Level 3: Instance method calling private module method internally
# =============================================================================
puts "Instance call: #{MathOperations.new.calculate(10, 5)}"

# =============================================================================
# What DOESN'T Work (and why)
# =============================================================================
# NOTE: Calling MathOperations.add(10,5) or MathOperations.new.add(10,5) directly would
# throw a NoMethodError because module_function makes them private!
#
# Uncommenting these would raise errors:
# MathOperations.add(10, 5)           # NoMethodError: private method `add'
# MathOperations.new.add(10, 5)       # NoMethodError: private method `add'
#
# But we CAN force it with send (bypasses visibility):
# MathOperations.send(:add, 10, 5)           # => 15 (works but breaks encapsulation)
# MathOperations.new.send(:add, 10, 5)       # => 15 (works but breaks encapsulation)
# =============================================================================
