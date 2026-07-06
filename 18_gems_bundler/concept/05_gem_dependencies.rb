#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Your gem depends on other gems. How do you declare that?
# Example: string_helpers needs 'json' to format output.
#
# Solution: add_dependency and add_development_dependency in the gemspec.
# Visibility: Runtime deps are installed with your gem. Dev deps only for contributors.

# Simulate a gemspec with dependencies:
puts 'Dependencies in a gemspec:'
puts <<~RUBY
  Gem::Specification.new do |spec|
    spec.name    = 'string_helpers'
    spec.version = '0.1.0'

    # Runtime dependencies — installed when someone installs your gem:
    spec.add_dependency 'json', '~> 2.0'

    # Development dependencies — only for working on the gem itself:
    spec.add_development_dependency 'minitest', '~> 5.0'
    spec.add_development_dependency 'rake', '~> 13.0'
  end
RUBY

# Usage: Check what a real gem depends on
puts "\nDependencies of 'json' gem:"
json_spec = Gem::Specification.find_by_name('json')
json_spec.dependencies.each do |dep|
  puts "  #{dep.name} #{dep.requirement}"
end
# json has no runtime dependencies (stdlib gem)

# This could also be done like this:
# In Gemfile (for applications, not gems):
#
#   gem 'json', '~> 2.0'           # runtime
#   group :development do
#     gem 'minitest', '~> 5.0'     # dev only
#   end
#
# Gemspec for gems, Gemfile for apps. A gem CAN have both:
# gemspec declares its own deps, Gemfile adds extras for development.
#
# Thinking in Ruby
#
# Ruby distinguishes between runtime and development dependencies as a first-class
# concept in the gemspec DSL. This separation reflects Ruby's philosophy of
# "optimizing for the reader" — when you publish a gem, users see exactly what
# they need at runtime, while contributors see what they need to work on the gem.
# The same distinction carries through to Bundler's group syntax in Gemfiles.
