#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Inline file
# This file contains Ruby code for inline file.

# Read and Write files
text = <<~EOT
  First line
  Second line
EOT

# Write to file
File.write('temp.txt', text)

# Read file
content = File.read('temp.txt', encoding: 'UTF-8')
puts content

# Read one line at a time
File.foreach('temp.txt', encoding: 'UTF-8') do |line|
  puts line.strip.upcase
end

# Read all lines into an Array
lines = File.readlines('temp.txt', chomp: true)
lines.each { |line| p line }

# Thinking in Ruby
#
# inline_file.rb shows three different file reading approaches — File.read
# (single slurp), File.foreach (streaming with block), File.readlines
# (array of lines) — highlighting Ruby's philosophy of multiple APIs for
# the same underlying operation. Each one communicates a different intent
# and memory profile, and Ruby trusts you to choose the right one.
