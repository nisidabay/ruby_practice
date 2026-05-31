#!/usr/bin/env ruby
# frozen_string_literal: true

# argf_demo.rb — ARGF reads from piped stdin OR file arguments
# Try: echo "hello" | ruby argf_demo.rb
#      ruby argf_demo.rb /etc/hostname

if ARGF.filename == "-" && !$stdin.tty?
  puts "Reading from pipe..."
end

ARGF.each_line.with_index(1) do |line, i|
  puts "#{i}: #{line.chomp.upcase}"
end
