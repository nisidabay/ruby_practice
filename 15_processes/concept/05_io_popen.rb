#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_io_popen.rb — IO.popen: bidirectional process communication
# Talk to a subprocess like a file — write input, read output.
# Unlike backticks (capture only) or system() (no capture),
# IO.popen gives you a pipe you can read AND write.

# ── Read-only: pipe stdout from a command ────────────────────────────

IO.popen(["ls", "-1", "/tmp"], "r") do |io|
  files = io.read
  puts "Files in /tmp: #{files.lines.count}"
  puts files.lines.first(3).join
end

# ── Write-only: pipe data into a command ─────────────────────────────

IO.popen(["wc", "-l"], "w") do |io|
  io.puts "line one"
  io.puts "line two"
  io.puts "line three"
  io.close_write  # signal EOF — wc can now count
end
# wc prints "3" to stdout

# ── Read+Write: interactive subprocess ───────────────────────────────

IO.popen(["gum", "filter", "--placeholder", "Pick one:"], "r+") do |io|
  io.puts "ruby"
  io.puts "nim"
  io.puts "python"
  io.close_write        # send options, then close input
  choice = io.read.strip # read the user's selection
  puts "\nYou picked: #{choice}"
end

# ── Error handling ───────────────────────────────────────────────────

begin
  IO.popen(["nonexistent_command"], "r") { |io| io.read }
rescue Errno::ENOENT => e
  puts "Command not found: #{e.message}"
end
