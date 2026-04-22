#!/usr/bin/env ruby
# frozen_string_literal: true

# Check file
# This file contains Ruby code for check file.

# Rubyists value clarity and "English-like" flow
path = ARGV[0]

if path.nil?
  puts 'Please provide a path.'
  exit
end

# The File class provides a highly readable API
if File.exist?(path)
  type = File.directory?(path) ? 'directory' : 'file'
  puts "The #{type} exists at: #{path}"
else
  puts 'Nothing found at that path.'
end
