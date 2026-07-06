#!/usr/bin/env ruby
# frozen_string_literal: true

# 35_at_exit.rb — register cleanup hooks that run when the program ends
#
# WITHOUT at_exit — cleanup scattered, forgettable:
#
#   Tempfile.new → must manually unlink
#   lockfile    → must manually delete
#   # Easy to forget when there are 5 exit paths (success, failure, abort, signal...)
#
# WITH at_exit — register once, Ruby guarantees it runs:

require "tempfile"

# Register cleanup BEFORE creating resources — LIFO order (last registered = first runs)
reminders = []

at_exit do
  puts "[at_exit] Cleaning up #{reminders.size} resources..."
  reminders.each { |msg| puts "  - #{msg}" }
end

# Simulate work that creates resources
reminders << "tempfile: /tmp/report-4291.csv"
reminders << "lockfile: deploy.lock"
reminders << "log buffer flushed"

puts "Program is running..."
puts "About to exit..."

# at_exit fires even on:
#   raise → exception bubbles up, at_exit still runs
#   exit  → explicit exit, at_exit still runs
#   end of script → implicit exit, at_exit still runs
#
# Does NOT fire on:
#   exit! → immediate hard exit, at_exit skipped
#   kill -9 → OS kills the process, no Ruby code runs

# Multiple at_exit blocks stack: last registered runs first (LIFO).
# Useful for: tempfile cleanup, lock releases, metric flushing, log closing.

# Thinking in Ruby
#
# at_exit registers cleanup hooks that run when the program exits — even
# on raise or exit (but not exit!). Multiple at_exit blocks stack in LIFO
# order. This is Ruby's answer to destructor-based RAII: register cleanup
# at resource creation time, guaranteed execution on teardown.
