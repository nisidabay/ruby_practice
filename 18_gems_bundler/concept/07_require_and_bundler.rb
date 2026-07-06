#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to load gems in your code — but which ones, and in what order?
# Example: Your script uses json and minitest. How do you make them available?
#
# Solution: require loads a gem (or stdlib). Bundler.require loads all Gemfile gems at once.
# Visibility: require is Ruby's built-in loader. Bundler.require is for Gemfile-managed projects.

# require — load one gem at a time:
require 'json'
puts "JSON loaded: #{JSON::VERSION}"

# require_relative — load YOUR project files (not gems):
puts "require_relative loads files relative to the current file"

# Bundler.require — load everything in your Gemfile (in a real project):
puts "\nIn a project with a Gemfile, you'd write:"
puts <<~RUBY
  require 'bundler/setup'   # set up load paths from Gemfile.lock
  Bundler.require            # require ALL gems in Gemfile
  # Now json, minitest, etc. are all available
RUBY

# Usage: Bundler.require with groups
puts "\nWith groups:"
puts <<~RUBY
  Bundler.require(:default)           # only production gems
  Bundler.require(:default, :test)    # production + test gems
RUBY

# This could also be done like this:
# Manual requires (no Bundler):
#
#   require 'json'
#   require 'minitest/autorun'
#
# Fine for small scripts. For projects with 10+ gems, Bundler.require
# saves you from forgetting one.
#
# Thinking in Ruby
#
# Ruby's require system is straightforward yet powerful — it leverages the
# $LOAD_PATH ($:) to resolve names to files, making gem loading a simple path
# lookup. Bundler.require extends this with batch loading and group awareness,
# but the fundamental mechanism remains the same. This design lets you start
# with a single-file script and scale up to a multi-gem application without
# changing how dependencies are loaded.
