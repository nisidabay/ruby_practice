#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You're developing a gem locally and want to use it in another project
# without publishing it to RubyGems.
# Example: Your `string_helpers` gem at ~/projects/string_helpers, used in ~/my_app.
#
# Solution: path: option in Gemfile — points to a local directory.
# Visibility: Bundler resolves it like any gem, but reads from disk.

puts 'Using a local gem in your Gemfile:'
puts <<~RUBY
  # Gemfile of ~/my_app
  source 'https://rubygems.org'

  gem 'string_helpers', path: '~/projects/string_helpers'
RUBY

puts "\nThis tells Bundler: 'Don't download string_helpers."
puts "Use the one at ~/projects/string_helpers instead.'"

# Usage: Also works with relative paths
puts "\nRelative path:"
puts "  gem 'string_helpers', path: '../string_helpers'"

# Usage: Git source — use a gem directly from a git repo
puts "\nGit source:"
puts "  gem 'string_helpers', git: 'https://github.com/you/string_helpers'"
puts "  gem 'string_helpers', git: '...', branch: 'develop'"

# This could also be done like this:
# Without Bundler — manually add to $LOAD_PATH:
#
#   $LOAD_PATH.unshift(File.expand_path('~/projects/string_helpers/lib'))
#   require 'string_helpers'
#
# But path: in Gemfile is cleaner — Bundler manages versions and dependencies.
