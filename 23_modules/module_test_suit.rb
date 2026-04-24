#!/usr/bin/env ruby
# frozen_string_literal: true

# =============================================================================
# RUBY MODULE PATTERNS - COMPREHENSIVE TEST SUITE
# =============================================================================
# This test suite demonstrates 5 fundamental module patterns in Ruby:
#
# Test 1: include - Instance methods from module
# Test 2: extend - Class methods from module  
# Test 3: extend self - Module as toolbox + public mixin
# Test 4: module_function - Public on module, private when mixed
# Test 5: include Enumerable - Custom collection with each
#
# Run: ruby module_test_suit.rb
# Expected: ✔️ All tests passed!
# =============================================================================

# =============================================================================
# TEST 1: Basic Module with include
# =============================================================================
# Pattern: Define module with instance methods, include in class
# Result: Methods become available on instances of the including class
# Visibility: PUBLIC
#
# Use case: Sharing behavior across multiple classes (mixins)
# Example: Comparable, Enumerable, Custom mixins
# =============================================================================

# Test 1: Basic module
module Greeter
  def say_hello
    'Hello!'
  end
end

# Class includes the module, gaining instance methods
class Person
  include Greeter
end

# Instance can call the method directly (public)
raise 'Test 1 failed' unless Person.new.say_hello == 'Hello!'

# =============================================================================
# TEST 2: extend for Class Methods
# =============================================================================
# Pattern: Define module with instance methods, extend a class with it
# Result: Methods become available on the CLASS itself (not instances)
# Visibility: PUBLIC
#
# Use case: Adding class-level utilities, factory methods, configuration
# Example: Class methods without polluting instance namespace
#
# Key difference from Test 1:
# - include → obj.method() works
# - extend  → Class.method() works (instances don't get the methods)
# =============================================================================

# Test 2: extend gives class methods
class Animal
  extend Greeter
end

# Class can call the method directly (public)
# Animal.new.say_hello would fail - instances don't get extended methods!
raise 'Test 2 failed' unless Animal.say_hello == 'Hello!'

# =============================================================================
# TEST 3: extend self Pattern (Module as Toolbox + Public Mixin)
# =============================================================================
# Pattern: Module extends itself with its own methods
# Result: 
#   - Methods available on module: Utils.add() ✓
#   - Methods public when included: obj.add() ✓
#   - Methods public when extended: Class.add() ✓
#
# Use case: Utility modules that should work both as toolbox AND mixin
# Example: Math utilities, string helpers, conversion functions
#
# Why extend self?
# - Cleaner than writing def self.method for every method
# - Methods stay public when mixed in (unlike module_function)
# - Single source of truth - define once, use everywhere
# =============================================================================

# Test 3: extend self pattern
module Utils
  extend self

  def add(a, b)
    a + b
  end
end

# 3a: Module-level call (toolbox pattern)
raise 'Test 3a failed' unless Utils.add(2, 3) == 5

# 3b: Instance call after include (public!)
# This works because extend self keeps methods public when included
raise 'Test 3b failed' unless Class.new { include Utils }.new.add(2, 3) == 5

# =============================================================================
# TEST 4: module_function (Hybrid Visibility Pattern)
# =============================================================================
# Pattern: Define method normally, then mark with module_function
# Result:
#   - Methods available on module: Calc.multiply() ✓ (PUBLIC)
#   - Methods private when included: obj.multiply() ✗ (PRIVATE)
#   - Must use send() or call internally: obj.send(:multiply) ✓
#
# Use case: 
#   - Expose clean API on module
#   - Hide helper methods when used as mixin
#   - Force encapsulation in classes
#
# Why module_function?
#   - Control visibility based on context
#   - Module = public API, Class = internal helper
#   - Prevents accidental misuse of helper methods
# =============================================================================

# Test 4: module_function makes private
module Calc
  def multiply(a, b)
    a * b
  end
  # This line changes visibility:
  # - Public on Calc module
  # - Private when included/extended in classes
  module_function :multiply
end

# 4a: Module-level call works (public)
raise 'Test 4a failed' unless Calc.multiply(3, 4) == 12

# 4b: Instance call requires send() (private)
# Direct call: Klass.new.multiply(3, 4) → NoMethodError
# Forced call: Klass.new.send(:multiply, 3, 4) → Works!
Klass = Class.new { include Calc }
raise 'Test 4b failed' unless Klass.new.send(:multiply, 3, 4) == 12

# =============================================================================
# TEST 5: include Enumerable (Custom Collection Pattern)
# =============================================================================
# Pattern: Include Enumerable and implement #each
# Result: Get map, select, reject, find, all? and 40+ other methods FREE!
#
# Use case: Making custom collections work with Ruby's enumeration protocol
# Example: Custom data structures, wrappers, filtered views
#
# Requirements:
#   - Must implement #each that yields elements
#   - Enumerable provides everything else based on #each
#
# Why Enumerable?
#   - Don't Repeat Yourself - implement once, get dozens of methods
#   - Consistent API across all Ruby collections
#   - Works with map, select, reduce, etc.
# =============================================================================

# Test 5: Enumerable
class MyArray
  include Enumerable

  def initialize(arr)
    @array = arr
  end

  # Required: Implement #each to delegate to internal collection
  # The & syntax is Ruby 3.4+ shorthand for &block
  def each(&)
    @array.each(&)
  end
end

# Now we get map, select, find, reject, etc. for free!
# Test with [1, 2, 4] → map { |x| x * 2 } → [2, 4, 8]
raise 'Test 5 failed' unless MyArray.new([1, 2, 4]).map { |x| x * 2 }.to_a == [2, 4, 8]

# =============================================================================
# SUMMARY: Module Pattern Comparison
# =============================================================================
# | Pattern          | Syntax           | Module.method | obj.method | Use Case        |
# |------------------|------------------|---------------|------------|-----------------|
# | include          | include Mod      | N/A           | ✓ Public   | Instance mixins |
# | extend           | extend Mod       | ✓ Public      | N/A        | Class mixins    |
# | extend self      | extend self      | ✓ Public      | ✓ Public   | Utilities       |
# | module_function  | module_function  | ✓ Public      | ✗ Private  | Hidden helpers  |
# | Enumerable       | include + each   | N/A           | ✓ Many!    | Collections     |
# =============================================================================

puts '✔️ All tests passed!'
