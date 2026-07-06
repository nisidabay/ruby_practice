#!/usr/bin/env ruby
# frozen_string_literal: true

# 13_file_metadata.rb — stat without opening: size, mtime, atime
#
# You don't always need the file's contents. Sometimes you just want
# facts about it — how big, when was it last modified, who owns it.
#
# WITHOUT stat methods — you open the file just to check:
#
#   content = File.read("log.txt")
#   puts content.bytesize  # 3GB read into RAM just to get the size
#
# WITH File.size / mtime / atime — zero-cost, no file open:

require "tempfile"

# Create a known file to inspect
Tempfile.create(["report", ".csv"]) do |tmp|
  tmp.write("id,name,score\n1,Alice,92\n2,Bob,87\n")
  tmp.rewind

  path = tmp.path

  puts "Path:    #{File.basename(path)}"
  puts "Size:    #{File.size(path)} bytes"         # does NOT open the file
  puts "mtime:   #{File.mtime(path)}"               # last modification time
  puts "atime:   #{File.atime(path)}"               # last access time
  puts "ftype:   #{File.ftype(path)}"               # "file", "directory", "link"

  # size is a single stat(2) syscall — no I/O beyond the inode lookup.
  # Compare with reading the whole file just to call .bytesize on it.
end

# Also available:
#   File.ctime(path)  — last metadata change (permissions, owner)
#   File.stat(path)   — returns a File::Stat with everything at once
#     stat.size, stat.mode, stat.uid, stat.gid, stat.blksize, stat.blocks
#   File.world_readable?(path)  — quick permission check
#   File.zero?(path)            — true if file exists and is 0 bytes

# Thinking in Ruby
#
# File.size, File.mtime, File.atime are pure stat(2) calls — they never
# open the file. In many languages you'd need to open a handle just to
# check the size. Ruby's File class exposes filesystem metadata as direct
# class methods, making it trivial to inspect files without touching their
# contents. File.stat gives you everything in one struct for when you
# need the full picture.
