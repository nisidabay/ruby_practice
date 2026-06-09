#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = { api_key: nil, endpoint: nil, timeout: 30, format: :json, port: nil }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  opts.on('-k', '--api-key KEY', 'API key (required)') { |v| options[:api_key] = v }
  opts.on('-e', '--endpoint URL', 'API endpoint (required)') { |v| options[:endpoint] = v }

  opts.on('-t', '--timeout SECS', Integer, 'Timeout in seconds (default: 30)') { |v| options[:timeout] = v }

  opts.on('-p', '--port PORT', 'Port number (1-65535)') do |v|
    port = Integer(v)
    abort "Port must be 1–65535, got #{port}" unless (1..65_535).cover?(port)
    options[:port] = port
  end

  opts.on('-j', '--json', 'JSON output')  { options[:format] = :json }
  opts.on('-x', '--xml',  'XML output')   { options[:format] = :xml  }
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

puts "API Key:  #{options[:api_key]}"
puts "Endpoint: #{options[:endpoint]}"
puts "Timeout:  #{options[:timeout]}s"
puts "Format:   #{options[:format]}"
# || is short-circuit: if port is nil, the right side kicks in as fallback
puts "Port:     #{options[:port] || '(not set)'}"
