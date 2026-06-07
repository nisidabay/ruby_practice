#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_validation.rb — What happens when the user gives bad input
#
# Validation happens at TWO levels:
#   1. Inside the block → raise OptionParser::InvalidArgument (caught by parser)
#   2. After parse! → check required options are present
#
# ERRORS GO TO $stderr, NOT stdout. Why? The pipe problem:
#
#   $ ./tool > result.txt          # user pipes stdout to a file
#   $ # if errors went to stdout, they'd be hidden in the file!
#
# $stderr bypasses the pipe — errors always reach the terminal.
#
#   ruby optparse_05_validation.rb --api-key abc --endpoint https://api.example.com
#   ruby optparse_05_validation.rb --api-key abc                    # missing endpoint
#   ruby optparse_05_validation.rb -p 99999                         # invalid port
#   ruby optparse_05_validation.rb -p 99999 > /dev/null             # error still visible!
#   ruby optparse_05_validation.rb -h

require "optparse"

options = { "api-key" => nil, "endpoint" => nil, timeout: 30, format: :json, port: nil }

parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  opts.on("-k", "--api-key KEY", "API key (REQUIRED)") do |key|
    options["api-key"] = key
  end

  opts.on("-e", "--endpoint URL", "API endpoint (REQUIRED)") do |url|
    options["endpoint"] = url
  end

  opts.on("-t", "--timeout SECS", Integer, "Timeout in seconds (default: 30)") do |t|
    options[:timeout] = t
  end

  opts.on("-p", "--port PORT", "Port number (1-65535)") do |port_str|
    port = Integer(port_str)
    if port < 1 || port > 65535
      raise OptionParser::InvalidArgument,
            "Port must be 1–65535, got #{port}"
    end
    options[:port] = port
  end

  opts.on("-j", "--json", "JSON output")  { options[:format] = :json  }
  opts.on("-x", "--xml",  "XML output")   { options[:format] = :xml   }

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end
end

# LEVEL 1: Parse-time errors (caught by rescue)
begin
  parser.parse!
rescue OptionParser::InvalidOption, OptionParser::InvalidArgument,
       OptionParser::MissingArgument => e
  $stderr.puts "Error: #{e.message}"
  $stderr.puts "Try '#{File.basename($0)} --help' for usage."
  exit 1
end

# LEVEL 2: Post-parse validation
required = %w[api-key endpoint]
missing  = required.reject { |k| options[k] }

if missing.any?
  $stderr.puts "Error: Missing --#{missing.join(', --')}"
  exit 1
end

# Success output → stdout (safe to pipe)
puts "API Key:  #{options['api-key'][0..4]}..."  # mask secret
puts "Endpoint: #{options['endpoint']}"
puts "Timeout:  #{options[:timeout]}s"
puts "Format:   #{options[:format]}"
puts "Port:     #{options[:port] || '(not set)'}"
