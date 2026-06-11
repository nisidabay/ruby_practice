#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to wrap or augment a method — run code BEFORE the original.
# Example: Log every call to debug? without modifying the Config class itself.
#
# Solution: prepend — inserts a module BEFORE the class in the ancestors chain.
# The module's method runs first, then super calls the original.
# Visibility: The module's methods override the class's — super reaches the original.

module LoggingConfig
  def debug?
    puts "[LOG] Checking debug status..."
    result = super   # calls the original Config#debug?
    puts "[LOG] Result: #{result}"
    result
  end
end

class Config
  prepend LoggingConfig  # inserted BEFORE Config in the chain

  def initialize
    @options = { debug: true }
  end

  def debug?
    @options[:debug] == true
  end
end

config = Config.new
puts "Ancestors: #{Config.ancestors.take(3)}"  # LoggingConfig, Config, Object
config.debug?
# Output:
#   [LOG] Checking debug status...
#   [LOG] Result: true

# This could also be done like this:
# include inserts AFTER the class — the class's method wins, not the module's:
#
#   module LoggingConfig
#     def debug?
#       puts "[LOG] Checking..."
#       super
#     end
#   end
#   Config.include(LoggingConfig)  # Config#debug? runs first, module never called
#
# Use prepend when you want the module to intercept. Use include when the
# class should win and the module is a fallback.
