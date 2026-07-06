#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to show all three visibility levels in one class for comparison.
# Example: Understanding when each visibility level allows or blocks method calls.
#
# Solution: Define public, protected, and private methods and test them.
# Visibility: Demonstrates all three levels with the same example.

class VisibilityDemo
  def public_method
    "I am PUBLIC - callable from anywhere"
  end

  protected

  def protected_method
    "I am PROTECTED - callable only by same-class instances"
  end

  private

  def private_method
    "I am PRIVATE - callable only within this class (no explicit receiver)"
  end

  # All methods are callable here (inside the class)
  def test_internal_calls
    [
      public_method,      # ✓ Works
      protected_method,   # ✓ Works (implicit receiver)
      private_method      # ✓ Works (implicit receiver)
    ]
  end

  # Test calling protected on another instance
  def compare_with(other)
    protected_method == other.protected_method  # ✓ Works
  end

  public :test_internal_calls, :compare_with
end

# Usage: Test visibility from outside the class
obj = VisibilityDemo.new

# Public methods work
puts obj.public_method
# => I am PUBLIC - callable from anywhere

# Protected methods fail from outside
# puts obj.protected_method
# => NoMethodError: protected method `protected_method'

# Private methods fail from outside
# puts obj.private_method
# => NoMethodError: private method `private_method'

# But internal calls work
puts obj.test_internal_calls
# => ["I am PUBLIC...", "I am PROTECTED...", "I am PRIVATE..."]

# Protected works between same-class instances
obj2 = VisibilityDemo.new
puts obj.compare_with(obj2)
# => true (both return the same string)

# This could also be done like this:
# Use respond_to? to check method visibility:
#
# obj.respond_to?(:public_method)           # => true
# obj.respond_to?(:protected_method)        # => false
# obj.respond_to?(:private_method)          # => false
# obj.respond_to?(:private_method, true)    # => true (include private)

# Thinking in Ruby
#
# This file demonstrates all three visibility levels in one class for
# side-by-side comparison. Public: callable anywhere. Protected:
# callable by same-class instances (using other.protected_method in
# compare_with). Private: callable only within the class with no
# explicit receiver. The test_internal_calls method shows all three
# working internally.
