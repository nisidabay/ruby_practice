#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want a method that accepts a variable number of positional
#          arguments without declaring each one.
# Example: deploy(env, *services) — services can be 1 or many.
#
# Solution: Use *name to capture the rest of the arguments into an Array.

def deploy(env, *services)
  puts "Deploying to #{env}: #{services.join(', ')}"
end

deploy("staging", "web")
deploy("production", "web", "worker", "scheduler")

# *services captures ["web"] in the first call, and
# ["web", "worker", "scheduler"] in the second.
#
# Without * you'd need separate methods or a hardcoded limit:
#
#   def deploy(env, s1)
#   def deploy(env, s1, s2)
#   def deploy(env, s1, s2, s3)
