#!/usr/bin/env ruby

# Refinements - Scoped Monkey Patching

# Refinements allow you to extend classes temporarily within a limited scope.
# This is safer than monkey patching because changes don't leak outside the module.

# Basic Definition: refine a class inside a module

module StringExtras
  refine String do
    def palindrome?
      self == reverse
    end

    def word_count
      split.count
    end
  end
end

# Using refinements with 'using' - applies to the current scope

class TextProcessor
  using StringExtras

  def analyze(text)
    puts "Words: #{text.word_count}"
    puts "Palindrome? #{text.palindrome?}"
  end
end

processor = TextProcessor.new
processor.analyze('racecar')
processor.analyze('hello world')

# Without 'using', the refinement is NOT available
# text.palindrome? # => NoMethodError

# Scope Rules: Refinements are lexically scoped

module Debug
  refine Object do
    def debug_inspect
      "<#{self.class}: #{self}>"
    end
  end
end

class A
  using Debug

  def self.show(obj)
    obj.debug_inspect # Works here
  end
end

class B
  # No 'using Debug' - refinement NOT available
  def self.show(obj)
    # obj.debug_inspect # => NoMethodError
    obj.inspect
  end
end

puts A.show('test') # => <String: test>

# Refinements are NOT inherited by subclasses

class Parent
  using Debug

  def inspect_with_debug
    debug_inspect
  end
end

class Child < Parent
  # No 'using Debug' - refinement NOT inherited
  def child_method
    # debug_inspect # => NoMethodError
  end
end

# 'using' must be at the top of a class/module or at method call

module MathHelpers
  refine Integer do
    def squared
      self * self
    end
  end
end

# You can use 'using' at the top level (global scope temporarily)

using MathHelpers

def calculate
  5.squared # Works because 'using' was called at file level
end

puts calculate # => 25

# Refinements can add new methods or override existing ones

module ArrayExtensions
  refine Array do
    def sum
      reduce(0, :+)
    end

    def first_or_default(default = nil)
      empty? ? default : first
    end

    def second
      self[1]
    end
  end
end

using ArrayExtensions

puts [1, 2, 3].sum # => 6
puts [].first_or_default('none') # => 'none'
puts [10, 20, 30].second # => 20

# Combining multiple refinements

module TimeRefinements
  refine Integer do
    def seconds
      self
    end

    def minutes
      self * 60
    end

    def hours
      self * 3600
    end
  end
end

using TimeRefinements

puts 5.minutes # => 300
puts 2.hours   # => 7200

# Refinements in blocks - using within a block scope

module TempRefinements
  refine String do
    def emphasized
      "*#{self}*"
    end
  end
end

module RefinementBlock
  using TempRefinements

  def self.with_emphasis(text)
    text.emphasized # Works because we have 'using' at module level
  end
end

puts RefinementBlock.with_emphasis('warning') # => *warning*
