#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to add methods to an existing class from outside its definition.
# Example: Add a debug? method to Config without reopening the class file.
#
# Solution: class_eval — opens the class and evaluates the block inside it.
# Visibility: PUBLIC — methods defined here are normal instance methods.

class Config
  def initialize
    @options = {}
  end
end

# Add a method from outside the class body:
Config.class_eval do
  def debug?
    @options[:debug] == true
  end
end

# Usage: Works like any normal method
config = Config.new
config.instance_eval { @options[:debug] = true }
puts config.debug?  # => true

# This could also be done like this:
# module_eval is the same thing — use it for modules instead of classes:
#
#   module Logger
#     module_eval do
#       def log(msg)
#         puts "[LOG] #{msg}"
#       end
#     end
#   end

# Thinking in Ruby
#
# class_eval reopens a class from anywhere in your program and adds methods
# to it. It's the runtime equivalent of reopening a class definition file.
# module_eval is the same for modules. This is Ruby's open classes in action:
# no class is ever truly finished — you can always add more.
