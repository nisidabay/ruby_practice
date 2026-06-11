#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to inspect a gem's structure — what files it has, its version, its metadata.
# Example: "What exactly is inside the 'json' gem?"
#
# Solution: Gem::Specification gives you full introspection of any installed gem.
# Visibility: Read-only — you can inspect but not modify installed gems.

# Find a gem by name:
spec = Gem::Specification.find_by_name('json')

puts "Gem: #{spec.name} #{spec.version}"
puts "  Summary:     #{spec.summary}"
puts "  Authors:     #{spec.authors.join(', ')}"
puts "  Homepage:    #{spec.homepage}"
puts "  License:     #{spec.license || 'none specified'}"
puts "  Installed at: #{spec.gem_dir}"

# List the gem's files:
puts "\n  Files (first 10):"
spec.files.take(10).each { |f| puts "    #{f}" }

# Dependencies:
puts "\n  Dependencies:"
spec.dependencies.each { |d| puts "    #{d.name} #{d.requirement}" }

# Usage: Iterate ALL installed gems
puts "\nAll gems with 'test' in the name:"
Gem::Specification.each.select { |s| s.name.include?('test') }.each do |s|
  puts "  #{s.name} #{s.version}"
end

# This could also be done like this:
# From the terminal:
#
#   gem spec json           # full gemspec in YAML
#   gem contents json       # list all files
#   gem dependency json     # show dependency tree
