#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want a wrapper method that forwards ALL arguments
#          (positional, keyword, AND block) to another method without
#          having to declare them separately.
# Example: log_and_call should log, then delegate everything to target.
#
# Solution: Use (...) to capture everything, then target(...) to forward.

def target(*args, **kwargs, &block)
  puts "  args: #{args}"
  puts "  kwargs: #{kwargs}"
  block&.call
end

def log_and_call(...)
  puts '[LOG] delegating...'
  target(...)
end

log_and_call('deploy', 'staging', dry_run: true) { puts '  block ran!' }

# Without (...), you'd write this every time:
#
#   def log_and_call(*args, **kwargs, &block)
#     puts '[LOG] delegating...'
#     target(*args, **kwargs, &block)
#   end
#
# (...) is shorthand for "forward everything."

# Thinking in Ruby
#
# The (...) forwarding syntax (Ruby 3.0+) is the culmination of Ruby's
# argument-design journey: it delegates *args, **kwargs, &block in one
# token. No other mainstream language has a shorthand this compact for
# complete argument forwarding — it captures Ruby's philosophy that
# common patterns should require zero ceremony.
