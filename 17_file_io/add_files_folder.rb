#!/usr/bin/env ruby
#
# Create directory and add files
require 'fileutils'

def add_files(folder, files)
  begin
    FileUtils.mkdir_p(folder)
  rescue StandardError
    abort("Error: Permission denied for '#{folder}'.")
  end

  files.each do |file_name|
    full_path = File.join(folder, file_name)

    next if File.exist?(full_path)

    begin
      File.write(full_path, 'I am a file')
    rescue StandardError
      puts("Error writing '#{file_name}'")
    end
  end
end

folder = ARGV[0] || 'vacation_2026'
files  = ARGV.length > 1 ? ARGV[1..-1] : ['a.txt', 'b.txt']

add_files(folder, files)
