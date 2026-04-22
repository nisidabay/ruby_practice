#!/usr/bin/env ruby
# frozen_string_literal: true
#
# File read
# This file contains Ruby code for file read.

# Ruby File I/O — All "Read" Methods (Ruby 3.3+)
# ===============================================================

require 'tempfile'
require 'pathname'

# Create a temporary file with sample content
sample_text = <<~TEXT
  Line 1: Hello World
  Line 2: This is a test file
  Line 3: Used for demonstrating read methods
  Line 4: Ruby is awesome!
TEXT

Tempfile.create(['demo', '.txt']) do |tmp|
  tmp.write(sample_text)
  tmp.rewind # important: reset position after writing
  path = tmp.path

  puts '=== 1. File.read (class method) ==='
  full = File.read(path)
  puts "Full content (#{full.lines.count} lines):\n#{full}"

  puts "\n=== 2. File.read with length limit ==="
  partial = File.read(path, 50)   # first 50 bytes
  puts "First 50 bytes: #{partial.inspect}"

  puts "\n=== 3. File.binread (binary-safe) ==="
  bin_data = File.binread(path, 20)
  puts "First 20 bytes (binary): #{bin_data.inspect} (size: #{bin_data.bytesize})"

  puts "\n=== 4. f.read (instance method) ==="
  File.open(path) do |f|
    chunk1 = f.read(30)           # read 30 bytes
    chunk2 = f.read               # read the rest
    puts "First chunk : #{chunk1.inspect}"
    puts "Rest of file: #{chunk2.lines.count} lines"
  end

  puts "\n=== 5. f.gets (safe line-by-line until EOF) ==="
  File.open(path) do |f|
    while (line = f.gets)
      print "→ #{line.chomp} | "
    end
    puts
  end

  puts "\n=== 6. f.readline (raises EOFError at end) ==="
  File.open(path) do |f|
    puts "Line 1: #{f.readline.chomp}"
    puts "Line 2: #{f.readline.chomp}"
    puts "Line 3: #{f.readline.chomp}"
    puts "Line 4: #{f.readline.chomp}"
    f.readline # will raise
  rescue EOFError
    puts '(EOFError caught — end of file reached)'
  end

  puts "\n=== 7. f.readlines (loads all lines into array) ==="
  lines_array = File.open(path) { |f| f.readlines.map(&:chomp) }
  puts "Total lines: #{lines_array.size}"
  puts "Last line  : #{lines_array.last}"

  puts "\n=== 8. f.each_line (lazy enumerator — memory-efficient) ==="
  File.open(path) do |f|
    errors_or_matches = f.each_line.grep(/Ruby|test/).map(&:chomp)
    puts "Lines matching /Ruby|test/: #{errors_or_matches}"
  end

  puts "\n=== 9. f.each_line (block iteration — idiomatic) ==="
  File.open(path) do |f|
    f.each_line.with_index(1) do |line, i|
      puts "#{i}: #{line.chomp}" if i <= 3 # show first 3 only
    end
  end

  puts "\n=== 10. Pathname#read ==="
  pn = Pathname.new(path)
  content = pn.read # same as File.read
  puts "Pathname#read returned #{content.length} characters"
  puts "First line via Pathname: #{pn.read.lines.first.chomp}"
end

puts "\n✅ All read methods demonstrated successfully!"
