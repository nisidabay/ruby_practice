#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Build a tiny configuration DSL that reads like natural language.
# Example: ConfigDSL.build { debug true; cache false } instead of hash syntax.
#
# Solution: Combine instance_eval + method_missing + define_method.
# instance_eval lets the block run inside the DSL object.
# Visibility: The DSL methods are only available inside the build block.

class Config
  attr_reader :options

  def initialize
    @options = {}
  end
end

class ConfigDSL
  def self.build(&block)
    config = Config.new
    dsl = new(config)
    dsl.instance_eval(&block)  # block runs with dsl as self
    config
  end

  def initialize(config)
    @config = config
  end

  # method_missing turns any unknown call into a config key:
  def method_missing(name, *args)
    @config.options[name] = args.first
  end

  def respond_to_missing?(name, include_private = false)
    true  # any method name is valid
  end
end

# Usage: Natural-language configuration
config = ConfigDSL.build do
  debug true
  cache false
  timeout 30
end

puts config.options  # => {debug: true, cache: false, timeout: 30}

# This could also be done like this:
# For a more structured DSL with fixed keys, use define_method instead:
#
#   class ConfigDSL
#     KEYS = %i[debug cache timeout]
#     def initialize(config)
#       @config = config
#       KEYS.each do |key|
#         define_method(key) { |val| @config.options[key] = val }
#       end
#     end
#   end
#
# define_method is safer (no typos) but less flexible than method_missing.
