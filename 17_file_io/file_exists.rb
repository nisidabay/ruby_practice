#!/usr/bin/env ruby
#
# Check file/dir existence
file = 'file_read.rb'

if File.exist?(file)
  if File.file?(file)
    puts "Regular file: #{File.size(file)} bytes"
  elsif File.directory?(file)
    puts "Directory with #{Dir.entries(file).size} entries"
  end
else
  puts "No file at #{file}"
end
