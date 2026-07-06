#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Backup ruby files
# This file contains Ruby code for backup ruby files.

# Find ruby files and make a backup

require 'fileutils'

home_dir = ENV.fetch('HOME', nil)
files_dir = 'Downloads/Refactor/practice_ruby'
source_dir = File.join(home_dir, files_dir)
backup_dir = File.join(source_dir, 'ruby_backup')

puts "Creating backup folder at: #{backup_dir}"
FileUtils.mkdir_p(backup_dir) unless Dir.exist?(backup_dir)

puts 'Looking for ruby files...'
conf_files = Dir.glob(File.join(source_dir, '**', '*.rb'))
conf_files.reject! { |f| f.start_with?(backup_dir) }

if conf_files.empty?
  puts 'No .rb files found!'
  exit
end

conf_files.each do |file|
  filename = File.basename(file)
  puts "Backing up: #{filename}"
  FileUtils.install(file, backup_dir)
end

puts 'Backup complete!'

# Thinking in Ruby
#
# backup_ruby_files demonstrates FileUtils.install — which copies files AND
# sets permissions — and Dir.glob with ** for recursive matching. The reject!
# filter prevents backing up the backup itself. This is Ruby's "batteries
# included" standard library: everything needed for filesystem automation
# is already there, no gems required.
