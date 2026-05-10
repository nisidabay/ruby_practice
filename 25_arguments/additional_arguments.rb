#!/usr/bin/env ruby
# frozen_string_literal: true

# additional_arguments.rb — splat captures extra args, keyword args are named

# Splat (*): variable number of positional arguments
def deploy(env, *services)
  puts "Deploying to #{env}: #{services.join(', ')}"
end

deploy("staging", "web")
deploy("production", "web", "worker", "scheduler")

# Keyword arguments with defaults — order doesn't matter, intent is explicit
def deploy_with(env:, region: "us-east-1", replicas: 2)
  puts "#{env} @ #{region} x#{replicas}"
end

deploy_with(env: "prod")
deploy_with(env: "staging", region: "eu-west-1", replicas: 1)
