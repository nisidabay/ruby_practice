#!/usr/bin/env ruby
# frozen_string_literal: true

# 36_file_program_name.rb — __FILE__ and $PROGRAM_NAME: is this script the entry point?
#
# Ruby lets code know whether it's being run directly or required by another file.
# Pattern: if __FILE__ == $PROGRAM_NAME — "I'm the main script, not a library"

# __FILE__: absolute path to this file (always)
puts "__FILE__:          #{__FILE__}"

# __dir__: directory this file lives in (same as File.dirname(__FILE__))
puts "__dir__:           #{__dir__}"

# $PROGRAM_NAME ($0): the script the USER invoked
puts "$PROGRAM_NAME:    #{$PROGRAM_NAME}"

# The key pattern: executable scripts vs libraries
if __FILE__ == $PROGRAM_NAME
  puts "\n→ I'm the main script — running directly."
  puts "  Use: ruby 36_file_program_name.rb"
else
  puts "\n→ I'm being required — acting as a library."
  puts "  Use: require_relative '36_file_program_name'"
end

# Real-world use:
#   if __FILE__ == $0
#     # CLI entry point: parse ARGV, run the app
#     MyApp.run(ARGV)
#   end
#
# This lets the SAME file be both a library (require it, use its classes)
# and a standalone script (run it from the command line).
