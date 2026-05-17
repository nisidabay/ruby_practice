#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_popen.rb — IO.popen: launch a process and talk to it like a file
#
# WITHOUT popen — capture output via backticks (loads everything into RAM):
#
#   all_logs = `grep ERROR /var/log/app.log`   # 500MB log → 500MB string
#
# WITH popen — read the output as a stream, line by line:

require "tempfile"

# Write a test log
Tempfile.create(["app", ".log"]) do |tmp|
  50.times { |i| tmp.puts "#{i % 5 == 0 ? 'ERROR' : 'INFO'}: event #{i}" }
  tmp.rewind

  # popen with "r" — read from the process stdout line by line
  error_count = 0
  IO.popen(["grep", "ERROR", tmp.path], "r") do |io|
    io.each_line do |line|
      error_count += 1
      print "." if error_count <= 10  # show first 10 as dots
    end
  end
  puts "\nTotal ERROR lines: #{error_count}"

  # popen with "w" — write to the process stdin
  IO.popen(["wc", "-l"], "w") do |io|
    (1..100).each { |n| io.puts "line #{n}" }
  end
  # wc reads stdin, counts 100 lines, prints "100" to its stdout (inherited)
end

# popen with "r+" — read AND write (bidirectional)
IO.popen(["cat", "-n"], "r+") do |io|
  io.puts "first"
  io.puts "second"
  io.close_write                # signal: no more input
  puts io.read                  # read numbered output
end

# popen is the Swiss Army knife for pipes — you get an IO object.
# Read it like a file, write to it like a file, stream don't buffer.
