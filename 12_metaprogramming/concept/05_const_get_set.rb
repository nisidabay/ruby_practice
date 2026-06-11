#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Look up or define constants dynamically — the name comes from a variable.
# Example: Load a config class by name: "ProductionConfig" → the actual class.
#
# Solution: const_get / const_set / const_defined? — constant manipulation.
# Visibility: Works on any module or class's constant namespace.

class Config
  VERSION = '1.0'

  def initialize
    @options = {}
  end
end

# Look up a constant by symbol:
puts Config.const_get(:VERSION)  # => 1.0

# Define a constant dynamically:
Config.const_set(:AUTHOR, 'Ruby Team')
puts Config::AUTHOR  # => Ruby Team

# Check before setting to avoid warnings:
name = :VERSION
if Config.const_defined?(name)
  puts "#{name} is already defined: #{Config.const_get(name)}"
end

# This could also be done like this:
# const_source_location (Ruby 2.7+) tells you WHERE a constant was defined:
#
#   puts Config.const_source_location(:VERSION).inspect
#   # => ["12_metaprogramming/concept/05_const_get_set.rb", 12]
