#!/usr/bin/env ruby
# frozen_string_literal: true

# 12_scan_unreadable.rb — scan a directory for files you can't open
#
# WITHOUT scanning — you discover permission problems at runtime, one at a time:
#
#   files.each { |f| File.read(f) }  # 💥 EACCES on the 47th file
#
# WITH a scan — you know up front which files will fail:

require "tmpdir"
require "fileutils"

# Build a test directory with mixed permissions
dir = Dir.mktmpdir
readable = File.join(dir, "public.txt")
locked   = File.join(dir, "secret.txt")

File.write(readable, "anyone can read this\n")
File.write(locked,   "classified\n")
File.chmod(0o000, locked)   # no permissions at all

# ── The scan ──
Dir.children(dir).each do |name|
  full = File.join(dir, name)

  begin
    File.read(full)
    puts "  ✓ #{name} — readable"
  rescue Errno::EACCES
    puts "  ✗ #{name} — PERMISSION DENIED (can't open)"
  rescue Errno::ENOENT
    puts "  ✗ #{name} — GONE (deleted mid-scan)"
  end
end

# Reset permissions so we can clean up
File.chmod(0o644, locked)
FileUtils.rm_rf(dir)

# Real-world use: run this before a batch operation.
#   scan(dir)   → collect unreadable files
#   fix/alert/skip them
#   THEN run the actual read loop
# No surprises mid-batch.
