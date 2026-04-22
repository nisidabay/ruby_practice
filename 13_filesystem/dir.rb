#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Dir
# This file contains Ruby code for dir.

# Dir class

require 'fileutils' # For removing non-empty directories

# Get user's home directory
home_dir = ENV.fetch('HOME', nil)

# Show current directory
puts "Current directory: #{Dir.pwd}"

# Change to home directory and list contents
Dir.chdir(home_dir) do
  puts "Home directory: #{Dir.pwd}"
  puts "Contents: #{Dir.entries(home_dir).join(', ')}"
end

# List Ruby files in current directory
puts "\nRuby files: #{Dir.glob('*.rb').join(', ')}"

# Create a test directory with files
test_dir = 'caca'
Dir.mkdir(test_dir) unless Dir.exist?(test_dir)

Dir.chdir(test_dir) do
  # Create two text files
  File.write('file1.txt', "hello file1.txt\n")
  File.write('file2.txt', "hello file2.txt\n")
  puts "Files created in '#{test_dir}': #{Dir.entries('.').join(', ')}"
end

# Clean up: remove test directory and all .txt files
Dir.chdir(home_dir)

FileUtils.rm_rf(test_dir)
puts "\n'#{test_dir}' removed: #{!Dir.exist?(test_dir)}"

# Delete all .txt files
txt_files = Dir.glob('*.txt')
txt_files.each { |file| File.delete(file) }
puts "Deleted .txt files: #{txt_files.join(', ')}"
