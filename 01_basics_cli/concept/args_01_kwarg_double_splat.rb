#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want a method that accepts a few known keywords plus
#          any number of extra ones you don't need to declare upfront.
# Example: create_user must have name and email, but plan, region,
#          dry_run, etc. should "just work" without changing the signature.
#
# Solution: Use **options to capture all undeclared keyword arguments
#           into a Hash.

def create_user(name:, email:, **options)
  puts "Creating #{name} (#{email})"
  options.each { |k, v| puts "  #{k}: #{v}" }
end

create_user(name: 'Ana', email: 'ana@dev.io', plan: 'pro', region: 'eu-west-1', dry_run: true)

# Without ** you'd have to declare every keyword:
#
#   def create_user(name:, email:, plan:, region:, dry_run:)
#     ...
#   end
#
# Adding a new option means changing every caller. ** avoids that.

# Thinking in Ruby
#
# The double-splatted parameter (**) captures undeclared keyword arguments
# into a Hash, decoupling method signatures from callers. This is Ruby's
# answer to forward-compatible option hashes — add new options without
# changing the signature or breaking existing callers.
