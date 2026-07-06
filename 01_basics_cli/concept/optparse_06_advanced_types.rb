#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_advanced_types.rb — Array, restricted values, optional types
#
# You've seen Integer and Float (04). Here are three more type patterns:
#   1. Array       — collect values, either repeatable or comma-delimited
#   2. Enum set    — restrict to a whitelist of allowed values
#   3. Optional    — argument is typed but may be omitted
#
#   ruby optparse_06_advanced_types.rb -q best -g "high,medium" -p file
#   ruby optparse_06_advanced_types.rb -h

require "optparse"

options = { quality: nil, tags: [], playlist: nil }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  # ── Restricted values ──
  # OptionParser rejects anything NOT in the list
  opts.on("-q", "--quality QUALITY", %w[low medium high best],
          "Video quality (default: best)") do |q|
    options[:quality] = q
  end

  # ── Array, comma-delimited ──
  opts.on("-g", "--tags TAG1,TAG2", Array, "Comma-separated tags") do |tags|
    options[:tags] = tags
  end

  # ── Optional typed argument ──
  opts.on("-p", "--playlist [SOURCE]", %w[stdin file],
          "Playlist source (optional)") do |source|
    options[:playlist] = source
  end

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end
end

begin
  parser.parse!
rescue OptionParser::InvalidOption, OptionParser::InvalidArgument,
       OptionParser::MissingArgument => e
  $stderr.puts "Error: #{e.message}"
  exit 1
end

puts "Quality:    #{options[:quality] || '(not specified)'}"
puts "Tags:       #{options[:tags].inspect}"
puts "Playlist:   #{options[:playlist].inspect}"

# Thinking in Ruby
#
# OptionParser supports Array, enum whitelists, and optional typed
# arguments out of the box. Passing an array literal like %w[low medium
# high best] as the type argument restricts input — a declarative
# validation pattern that would require custom code in most languages.
