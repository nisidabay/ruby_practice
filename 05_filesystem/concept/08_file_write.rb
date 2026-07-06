#!/usr/bin/env ruby
# frozen_string_literal: true

# 08_file_write.rb — File.write: create or overwrite in one line
#
# WITHOUT File.write — three lines for a simple operation:
#
#   f = File.open("log.txt", "w")
#   f.puts "Backup completed"
#   f.close
#
# WITH File.write — one line:

require 'tempfile'
require 'tmpdir'
require 'fileutils'

dir = Dir.mktmpdir
path = File.join(dir, 'status.txt')

# Write (overwrites if exists)
File.write(path, "deploy: 2026-05-17 21:04 UTC\n")
puts "After write:     #{File.read(path).chomp}"

# Append — add to the end without touching existing content
File.write(path, "backup: 2026-05-17 21:05 UTC\n", mode: 'a')
puts "After append:    #{File.read(path).chomp}"

# File.write returns the byte count written
bytes = File.write(path, "OK\n")
puts "Bytes written:   #{bytes}"

FileUtils.rm_rf(dir)

# Also: File.write creates missing parent directories via its own Dir.mkdir
# path = "/tmp/app/v1/cache.json"  ← File.write won't create /tmp/app/v1/
# Use FileUtils.mkdir_p(File.dirname(path)) first if the dirs don't exist.

# Thinking in Ruby
#
# File.write is Ruby's answer to "I just want to save this file."
# One call, no open/close ceremony, and it returns the byte count so you
# can verify the write. The `mode: 'a'` option adds append behavior without
# changing the method name — a clean API surface. Ruby trusts you to manage
# parent directory creation separately rather than making guesses.
