#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_open3_capture.rb — run commands, capture stdout/stderr/status separately
require "open3"

stdout, stderr, status = Open3.capture3("ls", "-l", "/bin/bash")

puts "Exit: #{status.exitstatus}"
puts "STDOUT (#{stdout.lines.size} lines):"
puts stdout.lines.first(3)
puts "STDERR: #{stderr.empty? ? '(none)' : stderr}"

# Thinking in Ruby
#
# Open3.capture3 returns stdout, stderr, and exit status as separate
# values — a clean tuple that makes process output introspection
# trivial. Unlike backticks (stdout only) or system() (status only),
# capture3 gives you the complete picture: what the program said,
# what it complained about, and how it exited. Ruby thinks about
# subprocesses the same way it thinks about everything else — as objects.
