#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You have a wrapper method that receives keyword arguments
#          and needs to pass them through to another method unchanged.
# Example: deploy receives env plus extra flags; it must forward those
#          flags to run_checks without knowing what they are.
#
# Solution: Capture extra keywords with ** and forward with **.

def run_checks(dry_run: false, verbose: false, **extra)
  puts "  dry_run: #{dry_run}"
  puts "  verbose: #{verbose}"
  return if extra.empty?

  puts "  extra flags: #{extra.keys.join(', ')}"
  extra.each { |k, v| puts "    #{k}: #{v}" }
end

def deploy(env:, **flags)
  puts "Deploying to #{env}"
  run_checks(**flags)
end

deploy(env: 'staging', dry_run: true, verbose: true)
deploy(env: 'production', dry_run: false, verbose: true, retries: 3)
