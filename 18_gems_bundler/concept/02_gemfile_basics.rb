#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Your project needs specific gem versions. How do you declare them?
# Example: "This project needs json 2.x and minitest 5.x."
#
# Solution: Gemfile — a dependency manifest. Bundler reads it and installs exact versions.
# Visibility: Gemfile is at the project root. `bundle install` locks versions in Gemfile.lock.

# Create a minimal Gemfile (this is what you'd write in a real project):
gemfile_content = <<~RUBY
  # Gemfile — project dependencies
  source 'https://rubygems.org'

  gem 'json', '~> 2.0'      # pessimistic: >= 2.0, < 3.0
  gem 'minitest', '~> 5.0'  # testing framework
RUBY

puts 'A Gemfile looks like this:'
puts gemfile_content
puts "\nThen you run: bundle install"
puts 'This creates Gemfile.lock with exact versions.'

# Usage: Check if Bundler is available
begin
  require 'bundler'
  puts "\nBundler version: #{Bundler::VERSION}"
rescue LoadError
  puts "\nBundler not loaded (gem install bundler if missing)"
end

# This could also be done like this:
# Without a Gemfile — manual gem install (no version locking):
#
#   gem install json -v '~> 2.0'
#   gem install minitest
#
# But then other devs don't know which versions to install.
# Gemfile + Gemfile.lock = reproducible builds.
