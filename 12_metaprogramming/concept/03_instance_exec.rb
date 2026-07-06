#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Like instance_eval, but you need to pass external data into the block.
# Example: Read a specific key from @options, where the key comes from a variable.
#
# Solution: instance_exec — passes arguments to the block while changing self.
# Visibility: Same as instance_eval — private internals accessible.

class Config
  def initialize
    @options = { debug: true, cache: false, timeout: 30 }
  end
end

config = Config.new

# instance_exec lets us pass the key from outside:
key = :timeout
value = config.instance_exec(key) { |k| @options[k] }
puts "timeout = #{value}"  # => timeout = 30

# Usage: Pass multiple args too
puts config.instance_exec(:debug, :cache) { |a, b| "#{a}=#{@options[a]}, #{b}=#{@options[b]}" }

# This could also be done like this:
# If you don't need arguments, use instance_eval — it's simpler:
#
#   config.instance_eval { @options[:timeout] }
#
# instance_exec is only needed when the block needs data from the outside world.

# Thinking in Ruby
#
# instance_exec takes the best part of instance_eval — changing self — and
# adds the ability to pass external data into the block. This is critical
# when the block logic depends on variables from the caller's scope, not the
# object's internals. Ruby's block-scoping design means you never have to
# choose between access and parameter passing.
