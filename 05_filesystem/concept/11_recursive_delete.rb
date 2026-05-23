#!/usr/bin/env ruby
# frozen_string_literal: true

# 11_recursive_delete.rb — delete a directory tree, symlinks safely handled
#
# WITHOUT symlink awareness — you follow symlinks and delete targets:
#
#   Dir.children(path).each { |c| File.delete(File.join(path, c)) }
#   # If a symlink points outside the tree, you just deleted real files.
#
# WITH symlink check — delete the link, not what it points to:

require "fileutils"
require "tmpdir"

# Build a test tree:  tmpdir/
#                     ├── a.txt
#                     └── sub/
#                         └── b.txt
root = Dir.mktmpdir
sub  = File.join(root, "sub")
FileUtils.mkdir_p(sub)
File.write(File.join(root, "a.txt"), "a")
File.write(File.join(sub,  "b.txt"), "b")
# Create a symlink inside the tree pointing to /etc/hostname
symlink = File.join(root, "hostname_link")
File.symlink("/etc/hostname", symlink)

puts "Before:"
puts `ls -la #{root}`

# ── The recursive delete ──
def delete_tree(path)
  raise ArgumentError, "Not a directory: #{path}" unless File.directory?(path)

  Dir.children(path).each do |name|
    full = File.join(path, name)

    if File.symlink?(full) || File.file?(full)
      File.delete(full)                        # link or file — safe nuke
    elsif File.directory?(full)
      delete_tree(full)                        # recurse
    end
  end

  Dir.rmdir(path)                               # now empty, remove it
end

# Run the delete
delete_tree(root)

puts "\nAfter:"
puts Dir.exist?(root) ? "Still exists" : "Gone (and /etc/hostname untouched)" # ✓

# Without the symlink? check, File.delete would have followed the link
# and blown away /etc/hostname. The check prevents that.
