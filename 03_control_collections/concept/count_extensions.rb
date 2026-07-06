#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Count extensions
# This file contains Ruby code for count extensions.

# Use hashes to store file extensions

def analyze_extensions(dir = Dir.pwd)
  return unless File.directory?(dir)

  counts = Hash.new(0)
  Dir.glob(File.join(dir, '**/*')).each do |path|
    next if File.directory?(path)

    ext = File.extname(path).downcase
    counts[ext.empty? ? '(none)' : ext] += 1
  end

  counts.sort_by { |_, v| -v }.each do |ext, count|
    puts "#{ext.ljust(12)} : #{count}"
  end
end

analyze_extensions(ARGV.first || Dir.pwd)

# Thinking in Ruby
#
# Hash.new(0) creates a counting hash — every missing key defaults to 0,
# enabling the terse counts[ext] += 1 pattern. Combined with Dir.glob for
# recursive file traversal and File.extname for extension extraction, this
# is a complete analysis tool in 25 lines of Ruby.
