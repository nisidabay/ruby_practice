#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_readlines_vs_each_line.rb — eager array vs lazy enumerator (memory)
#
# WITHOUT lazy reading — readlines loads the ENTIRE file into an array:
#
#   lines = File.readlines("giant_log.txt")  # 2GB log → 2GB RAM gone
#   lines.each { |l| process(l) }
#
# WITH each_line — reads one line at a time, constant memory:
#
#   File.open("giant_log.txt") { |f| f.each_line { |l| process(l) } }
#
# For a 2GB log, this stays at ~4KB of memory instead of 2GB.

require "tempfile"

Tempfile.create(["access", ".log"]) do |tmp|
  tmp.write("GET /home 200\nPOST /login 401\nGET /admin 403\n")
  tmp.rewind

  # readlines — returns an Array, the whole file in memory
  puts "=== readlines (eager — whole file in RAM) ==="
  lines = File.open(tmp.path, &:readlines)
  puts "Type: #{lines.class} (#{lines.size} elements)"
  puts "Last line: #{lines.last.chomp}"

  # each_line — returns an Enumerator, one line at a time
  puts "\n=== each_line (lazy — streams line by line) ==="
  File.open(tmp.path) do |f|
    errors = f.each_line
              .grep(/4\d\d/)          # filter as we stream
              .map(&:chomp)
    puts "Error lines: #{errors}"
  end

  # each_line with .with_index — no counter variable needed
  puts "\n=== each_line.with_index ==="
  File.open(tmp.path) do |f|
    f.each_line.with_index(1) do |line, i|
      puts "  ##{i}: #{line.chomp}"
    end
  end
end

# Rule: reach for each_line unless you explicitly need a full array.
# grep, map, select, with_index — all work on the lazy enumerator.
