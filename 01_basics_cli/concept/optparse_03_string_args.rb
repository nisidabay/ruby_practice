#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_string_args.rb — Options that take a value (vs boolean flags in 01)
#
# In 01 the block received nothing (boolean toggle).
# Here the block receives the VALUE the user typed after the flag.
#
#   ruby optparse_03_string_args.rb -u https://youtube.com/watch?v=xyz
#   ruby optparse_03_string_args.rb --url "https://youtube.com/watch?v=abc" --output myvideo.mp4
#   ruby optparse_03_string_args.rb -h

require "optparse"

options = { url: nil, output: "download.mp4" }

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  # --url URL  →  "URL" is the value placeholder (shown in help)
  opts.on("-u", "--url URL", "Video URL (required)") do |url|
    options[:url] = url
  end

  opts.on("-o", "--output FILE", "Output file (default: download.mp4)") do |file|
    options[:output] = file
  end

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end
end.parse!

# Required-option check (preview of what 05 formalizes)
if options[:url].nil?
  $stderr.puts "Error: --url is required"
  exit 1
end

puts "URL:      #{options[:url]}"
puts "Output:   #{options[:output]}"
puts

puts "Would download video to: #{options[:output]}"
puts "dry-run mode enabled" if options[:dry_run]
