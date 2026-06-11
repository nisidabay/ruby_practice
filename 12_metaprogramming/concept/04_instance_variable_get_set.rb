#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Read or write an object's instance variable by name, from outside.
# Example: Inspect @options without knowing the class's API.
#
# Solution: instance_variable_get / instance_variable_set — direct ivar access.
# Visibility: Bypasses all access controls — use sparingly.

class Config
  def initialize
    @options = { debug: false, cache: true }
  end
end

config = Config.new

# Read an ivar by its symbol name:
opts = config.instance_variable_get(:@options)
puts "Current options: #{opts}"  # => {debug: false, cache: true}

# Write an ivar from outside:
config.instance_variable_set(:@options, { debug: true, cache: false })
puts "Updated: #{config.instance_variable_get(:@options)}"

# This could also be done like this:
# For bulk access to multiple ivars, instance_eval is cleaner:
#
#   config.instance_eval do
#     @options[:debug] = true
#     @options[:cache]  = false
#   end
#
# instance_variable_get/set is best for single-ivar access by dynamic name.
