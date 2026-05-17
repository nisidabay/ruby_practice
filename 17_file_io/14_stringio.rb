#!/usr/bin/env ruby
# frozen_string_literal: true

# 14_stringio.rb — fake IO in memory: test file code without files on disk
#
# WITHOUT StringIO — every test creates temp files:
#
#   Tempfile.create { |tmp| tmp.write("line1\nline2\n"); tmp.rewind; parse(tmp) }
#   # slow, needs cleanup, temp dir, disk I/O
#
# WITH StringIO — a string that quacks like an IO object:

require "stringio"

# StringIO acts like a file — read, gets, each_line, all work
data = "GET /home 200\nPOST /login 401\nGET /admin 403\n"
io = StringIO.new(data)

puts io.gets.chomp         # => "GET /home 200"
puts io.gets.chomp         # => "POST /login 401"
puts "Position: #{io.pos}" # => 38 (cursor moved by gets)

io.rewind                  # reset to start, like Tempfile
errors = io.each_line.grep(/4\d\d/).map(&:chomp)
puts "Errors: #{errors}"   # => ["POST /login 401", "GET /admin 403"]

# StringIO also accepts writes (like a writable file)
output = StringIO.new
output.puts "line one"
output.puts "line two"
output.rewind
puts "\nWritten: #{output.read.chomp}"  # reads back what was "written"

# Real use case: testing a method that expects an IO object
def count_lines(io)
  io.each_line.count
end

puts "\nFile lines: #{count_lines(StringIO.new("a\nb\nc\n"))}"  # => 3 — no disk

# StringIO is how you unit-test File-processing code.
# Any method that takes a File can take a StringIO instead.
