#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — File operations and system commands

# --- Create a temp file, write to it, read it back, then delete it ---
require "fileutils"
require "tempfile"

# temp = Tempfile.new("practice")
# temp.write("Ruby system utilities practice\n")
# temp.rewind
# puts temp.read
# temp.close
# temp.unlink  # deletes the file
# puts "File deleted — no trace left!"

# --- Run a system command and capture its output ---
# Hint: `ls -l`.chomp or system("echo hello")
output = `date`
puts "Today is: #{output.strip}"

# --- Check if a file exists ---
# path = File.join(Dir.home, ".bashrc")
# puts File.exist?(path) ? "Found .bashrc" : "No .bashrc"
