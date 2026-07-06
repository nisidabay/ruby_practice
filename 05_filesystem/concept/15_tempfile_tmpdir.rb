#!/usr/bin/env ruby
# frozen_string_literal: true

# 37_tempfile_tmpdir.rb — Tempfile and Dir.mktmpdir: self-cleaning temp resources
#
# WITHOUT Tempfile — manual temp path + cleanup:
#
#   path = "/tmp/report-#{Process.pid}.csv"
#   File.write(path, data)
#   # ... then somewhere far away: File.delete(path) if File.exist?(path)
#   # Easy to leak files. If the program crashes, cleanup never runs.
#
# WITH Tempfile — the file automatically deletes itself when the block ends:

require "tempfile"
require "tmpdir"

# Tempfile.create with a block — auto-deleted after the block
Tempfile.create(["deploy", ".json"]) do |tmp|
  tmp.write('{"env":"staging","version":"3.2.1"}')
  tmp.rewind

  puts "Path: #{tmp.path}"          # => something like /tmp/deploy20260517-1234.json
  puts "Content: #{tmp.read.chomp}"
end
# File is GONE now — block exited, Tempfile unlinked it

# Dir.mktmpdir — same pattern, self-cleaning directory
Dir.mktmpdir do |dir|
  File.write(File.join(dir, "config.yml"), "host: localhost")
  puts "\nTemp dir: #{dir}"
  puts "Contents: #{Dir.children(dir)}"
end
# Directory and all contents deleted after the block

# Without a block: you must unlink manually
tmp = Tempfile.new("manual")
puts "\nManual: #{tmp.path}"
tmp.close
tmp.unlink  # explicit cleanup — easy to forget!

# Rule: ALWAYS use the block form unless you have a specific reason not to.
# The block guarantees cleanup on success, error, or even abort.

# Thinking in Ruby
#
# Tempfile.create and Dir.mktmpdir with blocks are Ruby's "autoclose"
# pattern — the block guarantees cleanup even if an exception is raised.
# This is safer-than-threadsafe resource management baked into the standard
# library. The block form is the idiomatic Ruby way: pass a block, get
# automatic lifecycle management, never leak temporary files.
