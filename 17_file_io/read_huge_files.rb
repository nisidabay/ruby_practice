#!/usr/bin/env ruby
#
# Way to read huge files
File.foreach('test.txt') do |line|
  puts line
end

# Some file stats
p File.size('test.txt')
p File.mtime('test.txt')
p File.atime('test.txt')
