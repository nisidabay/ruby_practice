#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to create your own gem — package your code for reuse.
# Example: A `StringHelpers` module you want to share across projects.
#
# Solution: A .gemspec file describes your gem. `gem build` creates the .gem file.
# Visibility: The gemspec is pure Ruby — it uses Gem::Specification.new.

# This is what a .gemspec looks like (we'll build one):
gemspec_content = <<~RUBY
  Gem::Specification.new do |spec|
    spec.name        = 'string_helpers'
    spec.version     = '0.1.0'
    spec.summary     = 'String utility methods'
    spec.authors     = ['Your Name']
    spec.files       = Dir['lib/**/*.rb']
    spec.require_paths = ['lib']
  end
RUBY

puts 'A .gemspec file:'
puts gemspec_content

# Usage: Build a gem from a gemspec
puts "\nCommands:"
puts '  gem build string_helpers.gemspec  # creates string_helpers-0.1.0.gem'
puts '  gem install string_helpers-0.1.0.gem'
puts "  # Then in your code: require 'string_helpers'"

# This could also be done like this:
# bundle gem — generates the whole skeleton for you:
#
#   bundle gem string_helpers
#   # Creates: lib/, spec/, Gemfile, .gemspec, README, LICENSE
#
# bundle gem is the standard way to start a new gem.
#
# Thinking in Ruby
#
# A .gemspec is executable Ruby code, not a static manifest file. This means you
# can compute file lists, read environment variables, or conditionally add
# dependencies using real programming logic. Ruby treats gem metadata with the
# same flexibility as any other code — your gem's definition is as dynamic as
# the library it describes.
