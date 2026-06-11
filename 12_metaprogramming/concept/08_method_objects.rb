#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Treat methods as first-class objects — store them, pass them, inspect them.
# Example: Get a reference to Config#debug? and call it later, or ask who owns it.
#
# Solution: method(:name) returns a Method object. instance_method(:name) returns UnboundMethod.
# Visibility: Method objects respect the method's original visibility.

class Config
  def initialize
    @options = { debug: true }
  end

  def debug?
    @options[:debug] == true
  end
end

config = Config.new

# Get a Method object — a callable reference:
m = config.method(:debug?)
puts m.call        # => true
puts m.owner       # => Config
puts m.parameters  # => []  (no parameters)

# Usage: Store methods, pass them around
methods = [config.method(:debug?), config.method(:to_s)]
methods.each { |meth| puts "#{meth.name} → #{meth.call}" }

# This could also be done like this:
# UnboundMethod is a method detached from its object — bind it to another:
#
#   unbound = Config.instance_method(:debug?)
#   config2 = Config.new
#   config2.instance_eval { @options[:debug] = false }
#   bound = unbound.bind(config2)
#   puts bound.call  # => false
