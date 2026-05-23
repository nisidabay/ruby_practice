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
