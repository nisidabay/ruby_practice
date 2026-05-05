#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

# dir.rb — Dir class basics: pwd, chdir, entries, glob, mkdir

home = ENV.fetch('HOME')
puts "Current: #{Dir.pwd}"

Dir.chdir(home) do
  puts "Home: #{Dir.pwd}"
  puts "Contents: #{Dir.entries(home).first(10).join(', ')}"
end

puts "Ruby files: #{Dir.glob('*.rb').join(', ')}"

test_dir = 'ruby_test_dir'
Dir.mkdir(test_dir) unless Dir.exist?(test_dir)

Dir.chdir(test_dir) do
  File.write('file1.txt', "hello\n")
  File.write('file2.txt', "hello\n")
  puts "Files: #{Dir.entries('.').join(', ')}"
end

Dir.chdir(home)
FileUtils.rm_rf(test_dir)
puts "Test dir removed: #{!Dir.exist?(test_dir)}"

