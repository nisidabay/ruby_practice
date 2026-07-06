#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Destructure an array — extract specific elements by position.
# Example: Parse a command like ["create", "user", "alice"] into action + type + name.
#
# Solution: Array patterns with [first, second, ...] and *rest.
# Visibility: Works in case/in, rightward assignment, and method args.

command = ['create', 'user', 'alice']

case command
in ['list', *args]
  puts "Listing with filters: #{args}"
in ['create', type, name]
  puts "Creating #{type} named '#{name}'"
in ['delete', id]
  puts "Deleting ID #{id}"
else
  puts "Unknown command: #{command}"
end
# => Creating user named 'alice'

# Usage: *rest captures remaining elements
data = [200, 'OK', 'text/html', 'gzip']
case data
in [code, msg, *headers]
  puts "#{code} #{msg}, headers: #{headers}"
end
# => 200 OK, headers: ["text/html", "gzip"]

# This could also be done like this:
# Without pattern matching — manual indexing (error-prone):
#
#   if command[0] == 'create'
#     type = command[1]
#     name = command[2]
#     puts "Creating #{type} named '#{name}'"
#   end
#
# Array patterns are safer: they check length AND extract in one step.

# Thinking in Ruby
#
# Array patterns destructure by position: [first, second, *rest] binds
# elements and captures the remainder in one expression. Unlike manual
# indexing (command[0], command[1]), array patterns verify the structure
# matches before extracting. This is Ruby's pattern matching philosophy
# — safe extraction by design, not by convention.
