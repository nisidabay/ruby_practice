#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_system_vs_backticks.rb — run external commands, 4 ways with different tradeoffs
#
# WITHOUT process calls — you rewrite `grep`, `find`, `curl` in Ruby:
#
#   matching = File.readlines("log.txt").grep(/ERROR/)  # slow for 10GB files
#
# WITH shell commands — let the native tool do what it's optimized for:

# 1. system — runs command, returns true/false, output goes to stdout
puts "=== system ==="
ok = system("echo", "deploy started")
puts "Exit status: #{ok}"  # => true

# 2. system with shell — runs through /bin/sh (watch for injection!)
system("ls #{__dir__}/*.rb | wc -l")  # string = through shell

# 3. Backticks — returns stdout as a string
puts "\n=== backticks ==="
count = `wc -l #{__dir__}/../30_exceptions/*.rb`
puts "Line counts:\n#{count}"

# 4. %x syntax — identical to backticks, more readable for multi-word
user = %x(whoami).chomp
puts "User: #{user}"

# system:  "Did it work?"   → returns true/false
# ``/ %x:  "What did it say?" → returns the output as a string
#
# NEVER interpolate user input directly — shell injection risk:
#   system("grep #{user_pattern} data.txt")  # user enters "; rm -rf /"
# Use the array form instead:
#   system("grep", user_pattern, "data.txt")  # safe, no shell parsing
