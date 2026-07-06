#!/usr/bin/env ruby
# frozen_string_literal: true

# 09_rescue_io_errors.rb — catch specific Errno classes, not StandardError
#
# File operations can fail for different reasons:
#   - file doesn't exist   → Errno::ENOENT
#   - permission denied    → Errno::EACCES
#   - disk full            → Errno::ENOSPC
#
# WITHOUT specific rescues — you catch everything and lose the WHY:
#
#   begin
#     File.read(path)
#   rescue StandardError
#     puts "Something went wrong"  # which thing? no idea.
#   end
#
# WITH specific Errno classes — you handle each failure differently:

config_path  = '/etc/passwd'        # exists, might not be readable
secret_path  = '/root/.ssh/id_rsa'  # exists, definitely not readable
missing_path = '/tmp/does_not_exist.txt'

[config_path, secret_path, missing_path].each do |path|
  print "#{path}: "

  begin
    content = File.read(path)
    puts "read #{content.bytesize} bytes"
  rescue Errno::ENOENT
    puts "NOT FOUND — the file doesn't exist"
  rescue Errno::EACCES => e
    puts "PERMISSION DENIED — #{e.message}"
  rescue Errno::EISDIR
    puts "IS A DIRECTORY — can't read it like a file"
  end
end

# Each error type gets its own handler. The user gets a useful message
# instead of a stack trace. And different failures can trigger different
# recovery: retry, skip, abort, fallback to a default file.

# Thinking in Ruby
#
# Ruby's Errno::* hierarchy is unique — each system error is its own class
# (Errno::ENOENT, Errno::EACCES, Errno::ENOSPC) so you can rescue exactly
# what you need. Most languages give you a single integer error code.
# Ruby gives you typed exceptions with descriptive class names, making
# error handling as expressive as the rest of the language.
