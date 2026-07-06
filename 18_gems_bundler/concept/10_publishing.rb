#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to publish a gem to RubyGems.org so others can install it.
# Example: Your `greeter` gem is ready — how do you share it with the world?
#
# Solution: gem push uploads your .gem file. But first: name must be unique,
# version must be higher than the last published version.
# Visibility: RubyGems.org is the public registry. Anyone can `gem install` after you push.

puts 'Publishing a gem to RubyGems.org:'
puts <<~STEPS
  1. Create an account at https://rubygems.org
  2. Run: gem signin                    (one-time setup)
  3. Build: gem build greeter.gemspec   (creates .gem file)
  4. Push:  gem push greeter-0.1.0.gem
  5. Done! Anyone can: gem install greeter
STEPS

# Check if a gem name is available (without publishing):
puts "\nChecking name availability (simulated):"
puts "  You can search at: https://rubygems.org/search?query=greeter"

# Usage: Versioning rules for publishing
puts "\nVersion rules:"
puts "  - First publish: 0.1.0"
puts "  - Bug fix:       0.1.1  (patch bump)"
puts "  - New feature:   0.2.0  (minor bump)"
puts "  - Breaking:      1.0.0  (major bump)"
puts "  - You CANNOT republish the same version"

# Usage: Yanking — unpublish a bad version
puts "\nIf you publish a broken version:"
puts "  gem yank greeter -v 0.1.0"
puts "  # Existing installs still work, new installs get the previous version"

# This could also be done like this:
# Private gem hosting (no RubyGems.org):
#
#   # In Gemfile:
#   source 'https://gems.my-company.com' do
#     gem 'internal_tools'
#   end
#
#   # Or self-host with geminabox:
#   # https://github.com/geminabox/geminabox
#
# Thinking in Ruby
#
# RubyGems.org is one of the first language-specific package registries, and its
# design reflects Ruby's community values: simple to publish, simple to install.
# The `gem push` / `gem yank` workflow is intentionally minimal — a single command
# to share your work. Versioning follows SemVer conventions, and the idea that
# "you cannot republish the same version" enforces immutability and trust in the
# supply chain.
