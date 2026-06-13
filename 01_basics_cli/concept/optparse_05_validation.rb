#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = { url: nil, format: nil, timeout: 30, json: false, xml: false, port: nil }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  opts.on('-u', '--url URL', 'Video URL (required)') { |v| options[:url] = v }
  opts.on('-f', '--format FORMAT', 'Output format: mp3, mp4, mkv (required)') { |v| options[:format] = v }

  opts.on('-t', '--timeout SECS', Integer, 'Timeout in seconds (default: 30)') { |v| options[:timeout] = v }

  opts.on('-p', '--port PORT', 'Port number (1-65535)') do |v|
    port = Integer(v)
    abort "Port must be 1–65535, got #{port}" unless (1..65_535).cover?(port)
    options[:port] = port
  end

  opts.on('-j', '--json', 'JSON output')  { options[:json] = true }
  opts.on('-x', '--xml',  'XML output')   { options[:xml] = true }
  opts.on('-h', '--help', 'Show this help') do
    puts opts
    exit
  end
end

begin
  parser.parse!
rescue OptionParser::InvalidOption, OptionParser::InvalidArgument,
       OptionParser::MissingArgument => e
  abort "Error: #{e.message}\nTry '#{File.basename($0)} --help' for usage."
end

abort "Error: --url is required" unless options[:url]
abort "Error: --format is required" unless options[:format]

puts "URL:      #{options[:url]}"
puts "Format:   #{options[:format]}"
puts "Timeout:  #{options[:timeout]}s"
puts "Port:     #{options[:port] || '(not set)'}"
puts "JSON:     #{options[:json]}"
puts "XML:      #{options[:xml]}"
