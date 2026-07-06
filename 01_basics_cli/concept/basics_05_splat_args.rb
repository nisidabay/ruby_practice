#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want a method that accepts a variable number of positional
#          arguments without declaring each one.
# Example: deploy(env, *services) — services can be 1 or many.
#
# Solution: Use *name to capture the rest of the arguments into an Array.

def deploy(env, *services)
  if services.size > 0
    puts "Deploying to #{env}: #{services.join(', ')}"
  else
    puts "Deploying to #{env}"
  end
end

deploy('staging', 'web')
deploy('branch')
deploy('production', 'web', 'worker', 'scheduler')

# Thinking in Ruby
#
# The splat (*) operator captures "the rest" of positional arguments into
# an Array, letting methods accept 0-to-N arguments without overloading.
# This is Ruby's answer to variadic functions — cleaner than varargs in
# C-family languages because the captured arguments are a real Array you
# can iterate, join, or guard against emptiness.
