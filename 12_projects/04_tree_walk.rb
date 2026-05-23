#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_tree_walk.rb — recursion for nested structures (filesystem)
#
# WITHOUT recursion — nested structures require manual stack management:
#
#   stack = [root]
#   while stack.any?; dir = stack.pop; stack.push(*subdirs); end
#
# WITH recursion — the call stack IS your data structure:

def walk(path, indent = 0)
  entries = Dir.children(path).sort

  entries.each do |name|
    full = File.join(path, name)
    prefix = "  " * indent

    if File.directory?(full) && !File.symlink?(full)
      puts "#{prefix}#{name}/"
      walk(full, indent + 1)  # recurse into subdirectory
    else
      size = File.size(full)
      puts "#{prefix}#{name}  (#{size} bytes)"
    end
  end
end

# Walk the 11_recursion directory itself
puts "#{File.basename(__dir__)}/"
walk(__dir__)

# This is a depth-first traversal. Each subdirectory pushes a new call frame.
# The call stack tracks "where am I?" naturally — no manual stack needed.
#
# Tree walk is where recursion shines: the problem structure (nested dirs)
# matches the solution structure (nested calls).
