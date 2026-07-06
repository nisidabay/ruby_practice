#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

# auto_backup.rb — backup *.conf files from source to backup directory

home_dir = ENV['HOME']
source_dir = File.join(home_dir, 'my_configs')
backup_dir = File.join(home_dir, 'my_configs_backup')

# Setup test files
FileUtils.mkdir_p(source_dir)
File.write(File.join(source_dir, 'settings.conf'), 'some settings')
File.write(File.join(source_dir, 'notes.txt'), 'ignore this file')

puts "Creating backup folder at: #{backup_dir}"
FileUtils.mkdir_p(backup_dir)

puts 'Looking for .conf files...'
conf_files = Dir.glob(File.join(source_dir, '*.conf'))

if conf_files.empty?
  puts 'No .conf files found.'
  exit
end

conf_files.each do |file|
  filename = File.basename(file)
  puts "Backing up: #{filename}"
  FileUtils.cp(file, backup_dir)
end

puts 'Backup complete!'

# Thinking in Ruby
#
# auto_backup.rb shows how a few lines of Ruby replace a complex shell script.
# Dir.glob finds .conf files, FileUtils.cp backs them up, File.join builds
# cross-platform paths — all without subprocesses, shell escaping, or
# platform-specific commands. Ruby's standard library is self-sufficient
# for filesystem automation.

