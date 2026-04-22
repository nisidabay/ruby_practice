#!/usr/bin/env ruby
# frozen_string_literal: true
require 'fileutils' # This is built into Ruby!
# Auto backup
# This file contains Ruby code for auto backup.


# 1. Using ENV to get the user's home directory
home_dir = ENV.fetch('HOME', nil)
source_dir = File.join(home_dir, 'my_configs')
backup_dir = File.join(home_dir, 'my_configs_backup')

# Let's create some dummy files just to test the script
FileUtils.mkdir_p(source_dir) # Bash equivalent: mkdir -p ~/my_configs
File.write(File.join(source_dir, 'settings.conf'), 'some settings')
File.write(File.join(source_dir, 'notes.txt'), 'ignore this file')

# 2. Creating the backup folder
puts "Creating backup folder at: #{backup_dir}"
FileUtils.mkdir_p(backup_dir)

# 3. Finding files (Replacing the 'find' command)
# Dir.glob searches for files matching a pattern
puts 'Looking for .conf files...'
conf_files = Dir.glob(File.join(source_dir, '*.conf'))

if conf_files.empty?
  puts 'No .conf files found.'
  exit
end

# 4. Copying files (Replacing the 'cp' command)
conf_files.each do |file|
  # File.basename gets just the file name, ignoring the folder path
  filename = File.basename(file)

  puts "Backing up: #{filename}"
  # Bash equivalent: cp file backup_dir/
  FileUtils.cp(file, backup_dir)
end

puts 'Backup complete!'

# Bonus: How to delete a folder and all its contents safely
# FileUtils.rm_rf(backup_dir) # Bash equivalent: rm -rf folder
