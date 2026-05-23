#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Dir class: list, change, create, delete

# --- Current working directory ---
puts "CWD: #{Dir.pwd}"

# --- List contents of home directory (first 5) ---
home_listing = Dir.children(Dir.home)
puts "First 5 in home: #{home_listing.first(5).inspect}"

# --- Change directory, do something, change back ---
old_dir = Dir.pwd
Dir.chdir(Dir.home)
puts "Moved to: #{Dir.pwd}"
Dir.chdir(old_dir)
puts "Back to: #{Dir.pwd}"

# --- Does a directory exist? ---
puts "r_ruby_practice exists? #{Dir.exist?("#{Dir.home}/r_ruby_practice")}"

# --- BONUS: Create a temp dir, write a file, clean up ---
# require "tmpdir"
# Dir.mktmpdir("ruby_practice_") do |dir|
#   File.write("#{dir}/test.txt", "hello")
#   puts File.read("#{dir}/test.txt")
# end  # auto-deleted
