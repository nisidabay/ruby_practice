#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You've heard "Ruby gems" but don't know what they actually are.
# Example: `require 'json'` — where does that code come from?
#
# Solution: A gem is a packaged Ruby library. RubyGems (built into Ruby) manages them.
# Visibility: Installed gems live in a gem path. `gem list` shows what you have.

# Check where your gems live:
puts "Ruby version: #{RUBY_VERSION}"
puts "Gem path: #{Gem.path.join(':')}"

# List installed gems (first 10):
puts "\nInstalled gems (sample):"
Gem::Specification.each.take(10).each do |spec|
  puts "  #{spec.name} #{spec.version}"
end

# Usage: Every `require` you've ever written loads a gem (or stdlib).
# `require 'json'` → loads the json gem (or stdlib json).
# `require 'optparse'` → stdlib, not a gem.

# This could also be done like this:
# From the terminal:
#
#   gem list          # all installed gems
#   gem which json    # where json is installed on disk
#   gem environment   # paths, versions, config
#
# RubyGems is part of Ruby itself — no install needed.
