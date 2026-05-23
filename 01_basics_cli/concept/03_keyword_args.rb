#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_keyword_args.rb — double-splat ** captures extra keyword args
#
# WITHOUT double-splat — every keyword must be declared:
#
#   def create_user(name:, email:, plan:, region:, dry_run:)
#     # adding a new option means changing the method signature everywhere
#   end
#
# WITH ** — capture and forward unknown options:

def create_user(name:, email:, **options)
  puts "Creating #{name} (#{email})"
  options.each { |k, v| puts "  #{k}: #{v}" }
end

create_user(name: "Ana", email: "ana@dev.io", plan: "pro", region: "eu-west-1", dry_run: true)
# name/email are explicit, the rest lands in options

# Forwarding: pass options down to another method
def deploy(env:, **flags)
  puts "Deploying to #{env}"
  run_checks(**flags)  # pass all flags through to run_checks
end

def run_checks(dry_run: false, verbose: false, **)
  puts "  dry_run: #{dry_run}"
  puts "  verbose: #{verbose}"
end

puts
deploy(env: "staging", dry_run: true, verbose: true)

# Block arg: capture a block as an explicit parameter
def benchmark(label, &block)
  start = Time.now
  result = block.call      # same as yield
  elapsed = Time.now - start
  puts "#{label}: #{elapsed.round(4)}s"
  result
end

benchmark("calculation") { sleep(0.1); 42 }

# Argument forwarding (Ruby 2.7+): (...) passes everything through
def log_and_call(...)
  puts "[LOG] delegating..."
  target(...)             # forwards all positional, keyword, and block
end

def target(*args, **kwargs, &block)
  puts "  args: #{args}"
  puts "  kwargs: #{kwargs}"
  block&.call
end

log_and_call("deploy", "staging", dry_run: true) { puts "  block ran!" }
