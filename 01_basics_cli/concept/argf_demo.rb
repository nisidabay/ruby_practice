#!/usr/bin/env ruby
# frozen_string_literal: true

# argf_demo.rb — ARGF reads from piped stdin OR file arguments
# Try: echo "hello" | ruby argf_demo.rb
#      ruby argf_demo.rb /etc/hostname

puts 'Reading from pipe...' if ARGF.filename == '-' && !$stdin.tty?

ARGF.each_line.with_index(1) do |line, i|
  puts "#{i}: #{line.chomp.upcase}"
end

# Thinking in Ruby
#
# ARGF is a uniquely Ruby abstraction: it merges piped STDIN and file
# arguments into a single stream. Whether the user pipes data or lists
# files on the command line, the code stays the same — Unix tooling
# designed into the language rather than bolted on afterward.
