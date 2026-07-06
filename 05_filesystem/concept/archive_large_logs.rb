#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Log files
# This file contains Ruby code for log files.

# Check log files by size and move them
#

require 'fileutils'

Dir.glob('*.log').each do |file|
  next unless File.size(file) > 10 * 1024 * 1024 # > 10 MB

  FileUtils.mv file, "/var/log/archive/#{file}_#{Time.now.strftime('%Y%m%d')}"
  puts "Archived large log: #{file}"
end

# Thinking in Ruby
#
# archive_large_logs.rb captures the brevity of Ruby for sysadmin tasks.
# Dir.glob finds log files, File.size checks the threshold, FileUtils.mv
# moves them — all in under 15 lines. The `next unless` guard keeps the
# flow clean. Ruby's expressive syntax lets you write shell-script-level
# conciseness with program safety and cross-platform compatibility.
