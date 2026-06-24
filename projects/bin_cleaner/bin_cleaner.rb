#!/usr/bin/env ruby
# frozen_string_literal: true
#
# bin_cleaner.rb — Find and remove Nim/C compiled ELF binaries.
#
# Uses `file` command + regex to detect real compiled binaries
# (ELF executables) instead of guessing by file permissions.
#
# Concepts demonstrated:
#   - OptionParser (Group 01): CLI flags, --help auto-generation
#   - Regex (Group 02): Non-capturing groups (?:...), lazy quantifiers .+?
#   - Processes (Group 15): Shelling out to `file` via backticks
#   - Filesystem (Group 05): File operations with FileUtils
#
# Usage:
#   ruby bin_cleaner.rb              # Interactive: list + confirm + delete
#   ruby bin_cleaner.rb --list       # List only, no deletion
#   ruby bin_cleaner.rb --yes        # Delete without confirmation
#   ruby bin_cleaner.rb --help       # Show help

require 'fileutils'
require 'optparse'

BATCH_FILE = 'find . -type f -exec file {} + 2>/dev/null'

# Regex breakdown (see Group 02 concept files for details):
#   ^          — anchor to start of line
#   (.+?)      — capture path (LAZY — stops at first \": \" to handle colons in filenames)
#   :\s+       — colon + whitespace (file command's delimiter)
#   ELF 64-bit LSB — ELF header signature for 64-bit Linux binaries
#   (?:pie )?  — optional \"pie \" (position-independent executable) — NON-CAPTURING group
#   executable — literal, matches both \"executable\" and \"pie executable\"
ELF_REGEX = /^(.+?):\s+ELF 64-bit LSB (?:pie )?executable/

def find_elf_binaries
  `#{BATCH_FILE}`.each_line.filter_map do |line|
    match = line.match(ELF_REGEX)
    puts "Found: #{match[1]}" if match
    match&.[](1)  # return captured path or nil
  end
end

def remove_files(files)
  count = 0
  files.each do |f|
    next unless File.exist?(f)
    FileUtils.rm(f)
    puts "Removed: #{f}"
    count += 1
  end
  count
end

def list_files(files)
  if files.empty?
    puts 'No ELF binaries found.'
  else
    puts "\nFound #{files.size} ELF binary file(s):"
    files.each { |f| puts "  #{f}" }
  end
end

# Parse CLI options
options = { mode: :interactive }

OptionParser.new do |opts|
  opts.banner = "Usage: #{$PROGRAM_NAME} [OPTIONS]"

  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end

  opts.on('-l', '--list', 'List binaries without removing') do
    options[:mode] = :list
  end

  opts.on('-y', '--yes', 'Remove without confirmation') do
    options[:mode] = :auto
  end
end.parse!

binaries = find_elf_binaries

case options[:mode]
when :list
  list_files(binaries)
when :auto
  count = remove_files(binaries)
  puts "\nTotal files removed: #{count}"
else
  list_files(binaries)
  if binaries.empty?
    exit
  end

  print "\nRemove these #{binaries.size} file(s)? (y/N): "
  if $stdin.gets.strip =~ /^[Yy]$/
    count = remove_files(binaries)
    puts "\nTotal files removed: #{count}"
  else
    puts 'Operation cancelled.'
  end
end
