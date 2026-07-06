#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to access or modify an object's private internals from outside.
# Example: Set @options[:debug] on a Config object without a setter method.
#
# Solution: instance_eval — changes self to the object, so you can touch its ivars.
# Visibility: PRIVATE internals become accessible inside the block.

class Config
  def initialize
    @options = {}
  end
end

config = Config.new

# Without instance_eval, @options is invisible from outside.
# With it, we're inside the object:
config.instance_eval { @options[:debug] = true }

# Usage: Read it back the same way
puts config.instance_eval { @options[:debug] }  # => true

# This could also be done like this:
# If you need to pass external data into the block, use instance_exec instead:
#
#   level = :verbose
#   config.instance_exec(level) { |lvl| @options[:log_level] = lvl }
#   puts config.instance_eval { @options[:log_level] }  # => verbose

# Thinking in Ruby
#
# instance_eval changes self to any object, letting you touch its private
# parts as if you were inside it. Ruby's encapsulation is a convention,
# not a wall — instance_eval says "I know what I'm doing, let me in."
# It's the master key for testing, debugging, and metaprogramming.
