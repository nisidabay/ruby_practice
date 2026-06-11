#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Walk a directory tree recursively — find all .rb files, or all files modified today.
# Example: "Find every Ruby file in this project, no matter how deep."
#
# Solution: Find (stdlib) — recursive directory traversal.
# Visibility: `require 'find'`. Like `find` command but in Ruby.

require 'find'

# Find all Ruby files in the current project
puts 'Ruby files in r_ruby_practice (first 10):'
count = 0
Find.find('Dir.pwd') do |path|
  next unless path.end_with?('.rb')
  puts "  #{path.sub('Dir.pwd/', '')}"
  count += 1
  break if count >= 10
end

# Usage: Prune — skip a directory entirely
puts "\nSkipping .git directory:"
Find.find('Dir.pwd') do |path|
  if File.basename(path) == '.git'
    Find.prune  # skip this directory and all its contents
  end
  puts "  #{path.sub('Dir.pwd/', '')}" if path.end_with?('.md')
end

# This could also be done like this:
# Dir.glob with ** (simpler for pattern matching):
#
#   Dir.glob('**/*.rb')  # all .rb files recursively
#
# Find is for when you need logic during traversal (prune, stat checks,
# conditional skipping). Dir.glob is for simple pattern matching.
