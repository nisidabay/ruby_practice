#!/usr/bin/env ruby
# frozen_string_literal: true

# 09_stderr_exit_codes.rb — errors go to $stderr, not $stdout
#
# Run: ruby 09_stderr_exit_codes.rb --port 8080          # works
#      ruby 09_stderr_exit_codes.rb --port 99999          # fails (invalid port)
#      ruby 09_stderr_exit_codes.rb --port 99999 > out.txt # error still visible
#      echo $?                                            # non-zero = failure

# === THE PROBLEM ===
#
# When you write errors with `puts`, they go to $stdout:
#
#   puts "Error: invalid port"
#   exit 1
#
# If the user pipes output to a file:
#
#   $ ./tool --port 99999 > result.txt
#   $ cat result.txt
#   Error: invalid port      # ← hidden in the file, user never saw it
#
# The error is SILENT. The user thinks it succeeded.
# This is the pipe problem.

# === THE FIX ===
#
# Write errors to $stderr — the OS sends this stream to the terminal
# regardless of where $stdout is pointing:
#
#   $ ./tool --port 99999 > result.txt
#   Error: invalid port      # ← appears on screen even though stdout went to file
#   $ cat result.txt
#                            # ← file is empty, as expected for a failure

# === THE PATTERN ===
#
# Wrap parse! in begin/rescue. On failure:
#   - Write a CLEAN message to $stderr (not the stack trace)
#   - Exit with non-zero so shell knows it failed

require 'optparse'
require 'date'

options = { port: nil, date: nil }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  opts.on('-p', '--port PORT', 'Port number (1-65535)') do |port_str|
    port = Integer(port_str)
    if port < 1 || port > 65_535
      raise OptionParser::InvalidArgument,
            "Port must be between 1 and 65535, got #{port}"
    end
    options[:port] = port
  end

  opts.on('-d', '--date DATE', 'Date in YYYY-MM-DD format') do |date_str|
    unless date_str =~ /^\d{4}-\d{2}-\d{2}$/
      raise OptionParser::InvalidArgument,
            "Date must be YYYY-MM-DD format, got: #{date_str}"
    end
    Date.parse(date_str)
    options[:date] = date_str
  end

  opts.on('-h', '--help', 'Show this help message') do
    puts opts
    exit
  end
end

begin
  parser.parse!
rescue OptionParser::InvalidOption, OptionParser::InvalidArgument,
       OptionParser::MissingArgument => e
  $stderr.puts "Error: #{e.message}"
  $stderr.puts "Try '#{File.basename($0)} --help' for usage."
  exit 1
end

# Success output goes to $stdout — safe to pipe or redirect
puts "✓ Port: #{options[:port]}"
puts "✓ Date: #{options[:date] || '(not specified)'}"

# === HOW TO VERIFY ===
#
#   ruby 09_stderr_exit_codes.rb --port 99999 > out.txt
#   # → "Error: Port must be between..."     ← on screen (stderr)
#   # → out.txt is empty                      ← nothing leaked to stdout
#   # → echo $? → 1                           ← non-zero means failure
#
#   ruby 09_stderr_exit_codes.rb --port 8080 > out.txt && echo "OK"
#   # → out.txt has "✓ Port: 8080"           ← success to stdout
#   # → echo $? → 0                          ← zero means success
