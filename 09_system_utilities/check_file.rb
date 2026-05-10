#!/usr/bin/env ruby
# frozen_string_literal: true

# check_file.rb — File.exist? + File.directory? without exceptions

# WITHOUT File API — shell out every time:
#
#   `test -f /etc/hosts && echo "exists"`
#   # subprocess overhead, platform-specific, brittle parsing
#
# WITH File — Ruby-native, cross-platform:

path = ARGV[0] || "/etc/hosts"

if File.exist?(path)
  type = File.directory?(path) ? "directory" : "file"
  puts "#{path} is a #{type}"
else
  puts "#{path} not found"
end
