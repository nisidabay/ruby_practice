#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Open3, fork, signals practice

puts "=== 1. Capture command output ==="
require "open3"

stdout, stderr, status = Open3.capture3("uname", "-a")
puts "Exit: #{status.exitstatus}"
puts "STDOUT: #{stdout.chomp}"

puts "\n=== 2. Failed command — check stderr ==="
stdout, stderr, status = Open3.capture3("ls", "/nonexistent_zZz")
puts "Exit: #{status.exitstatus}"
puts "STDERR: #{stderr.chomp}"

puts "\n=== 3. Parallel work with fork ==="
child_pids = []
3.times do |i|
  pid = fork do
    sleep rand(0.1..0.5)
    puts "Worker #{i}: done"
    exit 0
  end
  child_pids << pid
end
child_pids.each { |pid| Process.wait(pid) }
puts "All #{child_pids.size} workers finished"

# --- BONUS: Write a script that spawns a command, pipes its output
# through `grep`, and prints matching lines — all via Open3.pipeline.
