#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_open3.rb — Open3: capture stdout, stderr, and exit status separately
#
# Backticks only give you stdout. system only gives you true/false.
# When you need BOTH output streams AND the exit code, use Open3.

require "open3"

# capture3: stdout, stderr, status — all three at once
stdout, stderr, status = Open3.capture3("ls", "/etc/hostname", "/etc/nope")

puts "stdout:  #{stdout.chomp}"
puts "stderr:  #{stderr.chomp}"
puts "exit:    #{status.exitstatus}"  # => 2 (ls returns 2 for missing files)

# capture2e: merged stdout+stderr (like shell 2>&1)
output, status = Open3.capture2e("ls", "/etc/hostname", "/etc/nope")
puts "\nMerged:\n#{output}exit: #{status.exitstatus}"

# popen3: streaming version — talk to stdin, stdout, stderr live
Open3.popen3("sort") do |stdin, stdout, stderr, wait_thread|
  stdin.puts "cherry"
  stdin.puts "apple"
  stdin.puts "banana"
  stdin.close  # signal EOF to sort

  puts "\nSorted:"
  stdout.each_line { |line| puts "  #{line.chomp}" }

  wait_thread.value  # wait for process to finish, get Process::Status
end

# When to use which:
#   system         — fire and forget, just need true/false
#   backticks      — need stdout as a string, don't care about stderr
#   Open3.capture3 — need stdout AND stderr AND exit status
#   Open3.popen3   — need to stream data to/from a long-running process
