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
project_root = File.expand_path('../..', __dir__)

Find.find(project_root) do |path|
  next unless path.end_with?('.rb')
  puts "  #{path.sub("#{project_root}/", '')}"
  count += 1
  break if count >= 10
end

# Usage: Prune — skip a directory entirely
puts "\nSkipping .git directory:"
Find.find(project_root) do |path|
  if File.basename(path) == '.git'
    Find.prune  # skip this directory and all its contents
  end
  puts "  #{path.sub("#{project_root}/", '')}" if path.end_with?('.md')
end

# This could also be done like this:
# Dir.glob with ** (simpler for pattern matching):
#
#   Dir.glob('**/*.rb')  # all .rb files recursively
#
# Find is for when you need logic during traversal (prune, stat checks,
# conditional skipping). Dir.glob is for simple pattern matching.
#
# Thinking in Ruby
#
# Ruby's Find library provides recursive directory traversal with a twist: you
# can prune subtrees using Find.prune. This is the kind of pragmatic feature
# that emerges from real sysadmin needs — "find all Ruby files but skip the
# .git directory and vendor/bundle." Combined with Find.prune, you get the
# power of the Unix find command with the expressiveness of Ruby blocks for
# conditional logic.
