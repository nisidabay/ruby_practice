#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_rescue_hierarchy.rb — rescue order matters: most specific first
#
# Ruby matches exceptions top-to-bottom. Put StandardError before its
# children and the specific rescue NEVER runs:
#
#   begin
#     File.read("/root/secrets")
#   rescue StandardError       # ❌ catches EVERYTHING — EACCES never reached
#     puts "Something failed"
#   rescue Errno::EACCES        # dead code, never executes
#     puts "Permission denied"
#   end
#
# WITH correct order — specific first, general last:

paths = [
  "/etc/hostname",            # exists, readable
  "/root/.bashrc",            # exists, not readable
  "/etc/nonexistent",         # doesn't exist
  "/usr/bin",                 # is a directory, not a file
]

paths.each do |path|
  begin
    content = File.read(path)
    puts "  ✓ #{path}: #{content.bytesize} bytes"
  rescue Errno::ENOENT
    puts "  ✗ #{path}: file not found"
  rescue Errno::EACCES
    puts "  ✗ #{path}: permission denied"
  rescue Errno::EISDIR
    puts "  ✗ #{path}: is a directory, not a file"
  rescue StandardError => e
    puts "  ✗ #{path}: unexpected — #{e.class}: #{e.message}"
  end
end

# Exception hierarchy (simplified):
#
#   Exception
#   ├── NoMemoryError, SystemExit, SignalException  ← never rescue these
#   └── StandardError              ← rescue THIS for application errors
#       ├── ArgumentError
#       ├── RuntimeError           ← what `raise "msg"` creates
#       ├── TypeError
#       ├── NameError
#       │   └── NoMethodError
#       ├── IOError
#       └── Errno::*               ← system-level errors (ENOENT, EACCES, etc.)
#
# Rule: rescue Errno::* for system errors, rescue your own custom classes
# for business logic errors, rescue StandardError as the last-ditch catch-all.

# Thinking in Ruby
#
# Ruby's rescue order matters — it matches top to bottom, like a case
# statement. Put the most specific errors first (Errno::ENOENT, Errno::EACCES)
# and StandardError last as the catch-all. This is the opposite of try/catch
# in many languages where the generic exception is often the only option.
# Ruby's error hierarchy is a tree, not a flat list — rescuing a parent
# catches all its children, so ordering is critical for correct behavior.
