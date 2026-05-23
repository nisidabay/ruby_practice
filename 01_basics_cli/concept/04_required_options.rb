#!/usr/bin/env ruby
# 04_required_options.rb - Validation and required options
# Run: ruby 04_required_options.rb -h
#      ruby 04_required_options.rb --api-key abc123
#      ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com

require 'optparse'

options = {}
missing_required = []

OptionParser.new do |opts|
  opts.banner = "Usage: 04_required_options.rb [options]"
  opts.separator ""
  opts.separator "Required options and validation patterns"
  opts.separator ""
  
  # Required option - we'll validate after parsing
  opts.on("--api-key KEY", "API key (required)") do |key|
    options[:api_key] = key
  end
  
  # Another required option
  opts.on("--endpoint URL", "API endpoint URL (required)") do |url|
    options[:endpoint] = url
  end
  
  # Optional but with dependency
  opts.on("--timeout SECONDS", Integer, "Request timeout in seconds") do |timeout|
    options[:timeout] = timeout
  end
  
  # Mutually exclusive options
  opts.on("--json", "Output in JSON format") do
    options[:format] = :json
  end
  
  opts.on("--xml", "Output in XML format") do
    options[:format] = :xml
  end
  
  opts.separator ""
  opts.separator "Examples:"
  opts.separator "  ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com"
  opts.separator "  ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com --timeout 30"
  opts.separator ""
  
  opts.on("-h", "--help", "Show this help message") do
    puts opts
    exit
  end
end.parse!

# Validation: Check required options
required = [:api_key, :endpoint]
missing = required.reject { |key| options.key?(key) }

if missing.any?
  puts "Error: Missing required options:"
  missing.each do |opt|
    puts "  --#{opt.to_s.gsub('_', '-')}"
  end
  puts ""
  puts "Try --help for usage information"
  exit 1
end

# Validation: Check mutually exclusive options
if options[:format] == :json && options[:xml]
  puts "Error: Cannot use both --json and --xml"
  exit 1
end

# Validation: Check dependent options
if options[:timeout] && options[:timeout] <= 0
  puts "Error: Timeout must be a positive number"
  exit 1
end

# Validation: URL format (basic check)
if options[:endpoint] && !options[:endpoint].start_with?('http')
  puts "Error: Endpoint must be a valid URL (start with http:// or https://)"
  exit 1
end

# All validations passed - demonstrate usage
puts "=" * 50
puts "Validation Passed - Configuration Ready"
puts "=" * 50
puts ""
puts "API Key:  #{options[:api_key][0..4]}..." # Mask most of the key
puts "Endpoint: #{options[:endpoint]}"
puts "Timeout:  #{options[:timeout] || 30} seconds"
puts "Format:   #{options[:format] || :json}"
puts ""
puts "Ready to make API calls!"
