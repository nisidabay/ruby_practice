#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want a module that works as a standalone toolbox,
# but you also want to include it in classes and keep methods PUBLIC.
# Example: Calculator.add(5, 3) works, and obj.add(5, 3) also works.
#
# Solution: Use extend self.
# Visibility: PUBLIC everywhere (module, instances, classes).

module Calculator
  # extend self: methods stay PUBLIC in mix-ins (unlike module_function)
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

# Works on the module
puts Calculator.add(10, 5)

# Works when included (methods stay public)
class MathOperations
  include Calculator
end

obj = MathOperations.new
puts obj.add(10, 5)

# Works when extended (methods stay public)
class AnotherClass
  extend Calculator
end

puts AnotherClass.subtract(10, 5)

# Thinking in Ruby
#
# extend self makes a module's instance methods double as module-level methods.
# It's a clever Ruby trick: inside the module body, `extend self` adds the
# module's own instance methods to itself as class methods. The result is a
# module that works both as Calculator.add (standalone) and obj.add (included).
# Unlike module_function, methods stay PUBLIC when mixed in — the programmer
# chooses the visibility, not the language.
