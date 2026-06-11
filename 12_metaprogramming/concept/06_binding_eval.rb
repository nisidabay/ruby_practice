#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Capture the current execution context and evaluate code strings later.
# Example: Store a "snapshot" of local variables and run dynamic code against them.
#
# Solution: binding + eval — binding captures scope, eval runs strings in it.
# Visibility: Full access to everything in scope at capture time.
# WARNING: Never eval user input — it can execute arbitrary code.

class Config
  def initialize
    @options = { debug: true }
  end
end

config = Config.new
key = :debug

# Capture the current scope (config + key are visible):
b = binding

# Later, evaluate a string in that captured context:
result = b.eval('config.instance_eval { @options[key] }')
puts "debug = #{result}"  # => debug = true

# Usage: binding captures local variables too
count = 42
b2 = binding
puts b2.eval('count * 2')  # => 84

# This could also be done like this:
# TOPLEVEL_BINDING gives you the global scope — but it's less safe:
#
#   TOPLEVEL_BINDING.eval('RUBY_VERSION')  # => "3.4.8"
#
# Prefer binding over TOPLEVEL_BINDING — it limits what code can access.
