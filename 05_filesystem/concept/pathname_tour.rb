#!/usr/bin/env ruby
# frozen_string_literal: true

# pathname_tour.rb — Pathname wraps File, Dir, IO into a single OOP interface
require "pathname"

root = Pathname.new("/usr/bin")
puts "Directory? #{root.directory?}"
puts "Bash exists? #{root.join("bash").exist?}"
puts "Parent: #{root.parent}"
puts "Home expanded: #{Pathname.new("~/.config").expand_path}"
