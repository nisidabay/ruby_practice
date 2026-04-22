#!/usr/bin/env ruby
require 'fileutils'

# 1. The Safety Net (Define this once)
def safely(action_name)
  yield # This runs the code inside the do/end block
rescue Errno::EACCES
  puts "Error: Permission denied while trying to #{action_name}."
rescue StandardError => e
  puts "Error: Unexpected failure during #{action_name} - #{e.message}"
end

# 2. The Business Logic (Clean and readable)
folder = ARGV[0] || 'vacation_2026'
files  = ARGV.length > 1 ? ARGV[1..-1] : ['a.txt', 'b.txt']

# Create the folder safely
safely("create directory '#{folder}'") do
  FileUtils.mkdir_p(folder)
end

# Create the files safely
files.each do |file_name|
  full_path = File.join(folder, file_name)

  next if File.exist?(full_path) # Skip early if it exists

  safely("write file '#{file_name}'") do
    File.write(full_path, 'I am a file')
  end
end
