#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — File operations practice
require 'optparse'

options = { path: '.', verbose: false }
OptionParser.new do |opts|
  opts.on("-p", "--path PATH") { |p| options[:path] = p }
  opts.on("-v", "--verbose") { options[:verbose] = true }
end.parse!

puts "=== Exercise 1: List files ==="
# HINT: Dir.glob(File.join(options[:path], '*'))

puts "
=== Exercise 2: File size ==="
# HINT: File.size(path) if File.file?(path)

puts "
=== Exercise 3: Copy ==="
# HINT: FileUtils.cp(src, dst, preserve: true) — require 'fileutils'
