#!/usr/bin/env ruby
# frozen_string_literal: true

# 10_safe_io_wrapper.rb — a yield wrapper that rescues IO errors once
#
# WITHOUT a wrapper — every file operation repeats the same rescue block:
#
#   begin
#     FileUtils.mkdir_p("backups")
#   rescue Errno::EACCES
#     puts "Permission denied creating backups"
#   end
#   begin
#     File.write("backups/db.sql", data)
#   rescue Errno::EACCES
#     puts "Permission denied writing db.sql"
#   end
#   # ... 10 more identical rescue blocks
#
# WITH a yield wrapper — define error handling once, reuse everywhere:

require "fileutils"
require "tmpdir"

def safely(action_name)
  yield
rescue Errno::EACCES
  puts "Permission denied: #{action_name}"
rescue Errno::ENOENT
  puts "Not found: #{action_name}"
rescue StandardError => e
  puts "#{action_name}: #{e.message}"
end

# Now every IO call wraps cleanly
dir  = File.join(Dir.tmpdir, "demo_#{Process.pid}")
path = File.join(dir, "data.txt")

safely("create directory #{dir}") { FileUtils.mkdir_p(dir) }
safely("write #{path}")           { File.write(path, "deploy ok\n") }
safely("read #{path}")            { puts File.read(path).chomp }

# Clean up
FileUtils.rm_rf(dir)

# The wrapper isn't limited to just printing errors. You could:
#   - retry with exponential backoff
#   - fall back to a different path
#   - log to a file instead of stdout
# The point: rescue logic lives in ONE place, not scattered across 20 calls.
