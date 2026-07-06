#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_signals_trap.rb — catch and handle Unix signals
trap("INT") do
  puts "\nCaught SIGINT — shutting down cleanly"
  exit 0
end

trap("TERM") do
  puts "Caught SIGTERM"
  exit 0
end

puts "PID: #{Process.pid} — press Ctrl-C or send SIGTERM"
puts "Send: kill #{Process.pid}"
puts "Waiting (times out in 5s)..."
sleep 5
puts "Done (no signal received)"

# Thinking in Ruby
#
# trap("INT") and trap("TERM") let Ruby programs handle Unix signals
# as blocks — no signal handler functions, no global state. The block
# runs when the signal arrives, and you decide what cleanup to do.
# Ruby's signal handling is Ruby's block style applied to OS-level
# events: the handler is just a closure you pass to trap.
