#!/usr/bin/env ruby
# frozen_string_literal: true

# 07_file_checks.rb — exist? / file? / directory? — what's actually there?
#
# File.exist? returns true for BOTH files and directories.
# That's not enough when you need to decide what to do next.
#
# WITHOUT the specific checks — you'd branch on exist? and guess wrong:
#
#   if File.exist?("data")        # true for both /tmp/data.log and /tmp/data/ dir
#     File.read("data")            # 💥 IsADirectoryError if it's a directory
#   end
#
# WITH file? and directory? — you know exactly what you're dealing with:

require 'tempfile'
require 'tmpdir'
require 'fileutils'

# Test against a real temp file
Tempfile.create(['report', '.csv']) do |tmp|
  path = tmp.path

  puts "Path:       #{path}"
  puts "exist?      #{File.exist?(path)}"      # => true
  puts "file?       #{File.file?(path)}"       # => true  (it's a regular file)
  puts "directory?  #{File.directory?(path)}"  # => false
  puts "size        #{File.size(path)} bytes"
end

# And a real directory
tmpdir = Dir.mktmpdir
puts "\nPath:       #{tmpdir}"
puts "exist?      #{File.exist?(tmpdir)}"      # => true
puts "file?       #{File.file?(tmpdir)}"       # => false
puts "directory?  #{File.directory?(tmpdir)}"  # => true
puts "entries     #{Dir.entries(tmpdir).size}" # includes . and ..
FileUtils.rm_rf(tmpdir)

# The safe pattern:
#   if File.file?("data.csv")
#     parse(File.read("data.csv"))
#   elsif File.directory?("data/")
#     process_dir("data/")
#   end
# File.exist? alone is a trap.
