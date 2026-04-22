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
