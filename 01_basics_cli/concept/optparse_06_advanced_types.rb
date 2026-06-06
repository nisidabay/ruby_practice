#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_advanced_types.rb — Array, restricted values, optional types
#
# You've seen Integer and Float (04). Here are three more type patterns:
#   1. Array       — collect values, either repeatable or comma-delimited
#   2. Enum set    — restrict to a whitelist of allowed values
#   3. Optional    — argument is typed but may be omitted
#
#   ruby optparse_06_advanced_types.rb -t ruby -t python -t go
#   ruby optparse_06_advanced_types.rb -i abc,def,ghi -f json
#   ruby optparse_06_advanced_types.rb -w 5
#   ruby optparse_06_advanced_types.rb -h

require "optparse"

options = { tags: [], ids: [], format: nil, wait: nil }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  # ── Array, repeatable ──
  # Each -t invocation ADDS to the array (must initialize as [] in defaults)
  opts.on("-t", "--tag TAG", Array, "Tags (repeatable)") do |tags|
    options[:tags] += tags
  end

  # ── Array, comma-delimited ──
  # Single invocation: -i a,b,c → ["a", "b", "c"]
  opts.on("-i", "--ids ID1,ID2,ID3", Array, "Comma-separated IDs") do |ids|
    options[:ids] = ids
  end

  # ── Restricted values ──
  # OptionParser rejects anything NOT in the list
  opts.on("-f", "--format FORMAT", %w[json xml yaml csv],
          "Output format") do |fmt|
    options[:format] = fmt
  end

  # ── Optional typed argument ──
  # Square brackets + type = typed if given, nil if omitted
  opts.on("-w", "--wait [SECONDS]", Integer, "Wait time") do |secs|
    options[:wait] = secs || 0
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

puts "Tags:   #{options[:tags].inspect}"
puts "IDs:    #{options[:ids].inspect}"
puts "Format: #{options[:format] || '(not specified)'}"
puts "Wait:   #{options[:wait].inspect}s"

if options[:tags].any?
  puts "\nTags joined: #{options[:tags].join(', ')}"
end
