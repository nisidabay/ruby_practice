#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_expand_path.rb — turn relative paths into absolute paths
#
# WITHOUT expand_path — relative paths depend on your cwd:
#
#   # cd /var/log  → File.read("app.log") reads /var/log/app.log
#   # cd /tmp      → File.read("app.log") reads /tmp/app.log (different file!)
#
# WITH expand_path + __dir__ — the path is anchored to the script, not cwd:

script_dir = __dir__
config     = File.expand_path('exercises.rb', script_dir)

puts "Script dir: #{script_dir}"
puts "Config:     #{config}"
# => /home/nisidabay/r_ruby_practice/17_file_io/exercises.rb

# expand_path is pure string math — the file doesn't need to exist.
# Check with File.exist? when you actually need the file:
puts "Exists?     #{File.exist?(config)}" # => true (exercises.rb is real)

# This fails — the path resolves but the file isn't there:
missing = File.expand_path('nowhere.txt', __dir__)
begin
  File.read(missing)
rescue Errno::ENOENT
  puts "Missing:    #{missing} → ENOENT (path resolved, file absent)"
end

# Common alternative: expand relative to user's home
# File.expand_path(".config/kitty/kitty.conf", Dir.home)

# Thinking in Ruby
#
# File.expand_path is pure string resolution — it doesn't touch the filesystem,
# so it never raises. This is Ruby's "fail late" philosophy in action: resolve
# the path early, check File.exist? only when you actually need the file.
# Combined with __dir__, it eliminates the #1 class of file bugs: paths
# that break when the working directory changes.
