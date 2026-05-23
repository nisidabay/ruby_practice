#!/usr/bin/env ruby
# frozen_string_literal: true

# 16_fileutils.rb — FileUtils: the swiss army knife for filesystem operations
#
# WITHOUT FileUtils — shell out or write verbose Ruby:
#
#   `cp -r source/ backup/`         # platform-specific, subprocess overhead
#   Dir.mkdir("a/b/c") rescue nil   # doesn't create parents
#
# WITH FileUtils — Ruby-native, cross-platform, handles edge cases:

require "fileutils"
require "tmpdir"

Dir.mktmpdir do |dir|
  src  = File.join(dir, "src")
  dest = File.join(dir, "backup")

  # mkdir_p: create full path (like mkdir -p)
  FileUtils.mkdir_p("#{src}/sub/deep")
  File.write("#{src}/readme.txt", "hello")
  File.write("#{src}/sub/deep/config.yml", "port: 3000")

  # cp_r: recursive copy
  FileUtils.cp_r(src, dest)
  puts "Backup exists: #{Dir.exist?(dest)}"

  # touch: update mtime or create empty file
  FileUtils.touch(File.join(dest, ".deployed"))
  puts "Touched: #{Dir.children(dest)}"

  # rm_rf: recursive force delete (DANGEROUS — but sometimes needed)
  FileUtils.rm_rf(dest)
  puts "Removed: #{Dir.exist?(dest)}"

  # chmod_R: recursive permissions
  FileUtils.chmod_R("u+w", src)
  puts "Writable: #{File.stat(src).mode.to_s(8)}"

  # cp, mv, rm, mkdir, rmdir, ln_s, chown, compare — all in one module
  # Most methods have :verbose and :noop (dry-run) options.
end

# FileUtils is the Ruby answer to shell scripting.
# Every method mirrors a Unix command but works on Windows too.
