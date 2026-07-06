#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Ensure a class has only ONE instance — global access point.
# Example: A configuration object that should be the same everywhere in the app.
#
# Solution: Singleton (stdlib) — mixin that enforces single instance.
# Visibility: `require 'singleton'`. `.instance` returns the one and only object.

require 'singleton'

class AppConfig
  include Singleton

  attr_accessor :debug, :cache, :timeout

  def initialize
    @debug = false
    @cache = true
    @timeout = 30
  end
end

# Get the instance — always the same object
config1 = AppConfig.instance
config2 = AppConfig.instance

puts "Same object? #{config1.equal?(config2)}"  # => true
config1.debug = true
puts "config2.debug: #{config2.debug}"  # => true  (same object)

# Usage: Cannot create new instances
begin
  AppConfig.new
rescue NoMethodError => e
  puts "Cannot call .new: #{e.message}"  # private method
end

# This could also be done like this:
# Manual singleton with private .new (group 04):
#
#   class AppConfig
#     private_class_method :new
#     def self.instance
#       @instance ||= new
#     end
#   end
#
# Singleton mixin does the same thing but also handles:
# - Thread safety (mutex on first creation)
# - Marshal serialization
# - Clone/dup prevention
#
# Thinking in Ruby
#
# Ruby's Singleton mixin is the idiomatic Ruby way to implement the Singleton
# pattern — a single include, a `.instance` method, and you're done. Unlike
# manual implementations that require careful thread-safety and clone prevention,
# the mixin handles all the edge cases. This is Ruby at its best: a complex
# design pattern reduced to a single line of code, with the implementation
# details handled by the standard library.
