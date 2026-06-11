#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Find an element inside an array without knowing its position.
# Example: Extract the :error marker from a mixed log array, wherever it is.
#
# Solution: Find patterns [*, target, *] — match sequences with unknown prefix/suffix.
# Visibility: Ruby 3.1+. The * acts as "zero or more elements I don't care about."

log = [:info, 'connected', :info, 'processing', :error, 'timeout', :info, 'done']

case log
in [*, :error, msg, *]
  puts "Found error: #{msg}"
in [*, :warn, msg, *]
  puts "Found warning: #{msg}"
else
  puts 'No errors or warnings'
end
# => Found error: timeout

# Usage: Find the LAST occurrence (search from the right)
mixed = [1, 2, :marker, 3, 4, :marker, 5]
case mixed
in [*, :marker, last_val]
  puts "Last marker followed by: #{last_val}"  # => Last marker followed by: 5
end

# Usage: Match start of array
commands = ['create', 'user', 'alice', '--verbose']
case commands
in ['create', *args]
  puts "Create command with args: #{args}"
in ['delete', *args]
  puts "Delete command with args: #{args}"
end
# => Create command with args: ["user", "alice", "--verbose"]

# This could also be done like this:
# Without find patterns — manual search:
#
#   error_idx = log.index(:error)
#   if error_idx
#     msg = log[error_idx + 1]
#     puts "Found error: #{msg}"
#   end
#
# Find patterns are more declarative — "I want this shape, find it."
