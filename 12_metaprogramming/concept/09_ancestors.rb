#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Understand how Ruby finds methods — the lookup chain.
# Example: When you call config.debug?, where does Ruby look? In what order?
#
# Solution: ancestors returns the full lookup chain. instance_method(:name).owner
# tells you exactly which class/module provides a method.
# Visibility: This is the Ruby object model — every class has this chain.

module Logger
  def log(msg)
    puts "[LOG] #{msg}"
  end
end

class Config
  include Logger

  def initialize
    @options = {}
  end

  def debug?
    @options[:debug] == true
  end
end

# The lookup chain: Config → Logger → Object → Kernel → BasicObject
puts 'Ancestors chain:'
Config.ancestors.each { |a| puts "  #{a}" }

# Find who owns each method:
puts "\nMethod owners:"
puts "  debug? → #{Config.instance_method(:debug?).owner}"   # Config
puts "  log    → #{Config.instance_method(:log).owner}"       # Logger
puts "  to_s   → #{Config.instance_method(:to_s).owner}"     # Object

# This could also be done like this:
# Method#super_method walks up the chain one step at a time:
#
#   m = Config.instance_method(:to_s)
#   puts m.owner           # => Object
#   puts m.super_method.owner  # => Kernel (or nil if at top)
