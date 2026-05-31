#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_open3_capture.rb — run commands, capture stdout/stderr/status separately
require "open3"

stdout, stderr, status = Open3.capture3("ls", "-l", "/bin/bash")

puts "Exit: #{status.exitstatus}"
puts "STDOUT (#{stdout.lines.size} lines):"
puts stdout.lines.first(3)
puts "STDERR: #{stderr.empty? ? '(none)' : stderr}"
