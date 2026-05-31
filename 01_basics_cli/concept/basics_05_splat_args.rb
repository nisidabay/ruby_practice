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
