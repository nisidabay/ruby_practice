#!/usr/bin/env ruby
# frozen_string_literal: true

# pathname_tour.rb — Pathname wraps File, Dir, IO into a single OOP interface
require "pathname"

root = Pathname.new("/usr/bin")
puts "Directory? #{root.directory?}"
puts "Bash exists? #{root.join("bash").exist?}"
puts "Parent: #{root.parent}"
puts "Home expanded: #{Pathname.new("~/.config").expand_path}"

# Thinking in Ruby
#
# Pathname wraps File, Dir, and IO into a single object-oriented interface.
# Instead of passing strings everywhere, Pathname gives you .join, .parent,
# .expand_path, .exist?, .read — all chainable. This is Ruby's OOP philosophy
# applied to filesystem paths: objects over strings, methods over functions,
# composition over concatenation. pathname is not just a convenience — it
# makes path logic testable and composable.
