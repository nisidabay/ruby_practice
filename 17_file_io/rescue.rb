#!/usr/bin/env ruby
#
# Using rescue for error handling
path = Dir.open('.')
file = 'top_secret.txt'
file_path = File.join(path, file)

begin
  File.read(file_path)
rescue Errno::ENOENT
  puts "File: #{file_path} do not exist"
rescue Errno::EACCES => e
  puts "File: #{file_path} Access denied"
  puts e.message
end
