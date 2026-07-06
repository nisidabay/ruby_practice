#!/usr/bin/env ruby

# frozen_string_literal: true

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

# Thinking in Ruby
#
# Module self-methods are Ruby's equivalent of static methods in other languages.
# But unlike Java's static methods, Ruby modules can also be included/extended,
# giving you a spectrum from pure namespace (self.methods) to mixin (instance methods).
# Starting with self.methods keeps things simple — you get the calculator as a
# named container without objects, inheritance, or instantiation.
