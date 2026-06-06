#!/usr/bin/env ruby
require 'optparse'

options = {
  'api-key' => nil,
  'endpoint' => nil,
  timeout: nil,
  format: nil
}

OptionParser.new do |opts|
  opts.banner = 'Usage: 04_required_options.rb [options]'
  opts.separator ''
  opts.separator 'Required options: -k/--api-key and -e/--endpoint'
  opts.separator ''

  # --- Option Definitions ---
  opts.on('-k', '--api-key KEY', 'API key (REQUIRED)') do |key|
    options['api-key'] = key
  end

  opts.on('-e', '--endpoint URL', 'API endpoint URL (REQUIRED)') do |url|
    options['endpoint'] = url
  end

  opts.on('-t', '--timeout SECONDS', Integer, 'Request timeout in seconds') do |timeout|
    options[:timeout] = timeout
  end

  opts.on('-j', '--json', 'Output in JSON format') do
    options[:format] = :json
  end

  opts.on('-x', '--xml', 'Output in XML format') do
    options[:format] = :xml
  end

  opts.separator ''
  opts.separator 'Examples:'
  opts.separator '  ruby 04_required_options.rb -k abc123 -e https://api.example.com'
  opts.separator '  ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com -t 30'
  opts.separator ''

  opts.on('-h', '--help', 'Show this help message') do
    puts opts
    exit
  end
end.parse!

required = %w[api-key endpoint]
missing = required.reject { |key| options[key] } # Keep only keys that have no value in options

if missing.any?
  puts 'Error: Missing required options:'
  missing.each do |opt|
    puts "  --#{opt}"
  end
  puts ''
  puts 'Try --help for usage information'
  exit 1
end

if options[:timeout] && options[:timeout] <= 0
  puts 'Error: Timeout must be a positive number'
  exit 1
end

if options['endpoint'] && !options['endpoint'].start_with?('http')
  puts 'Error: Endpoint must be a valid URL (start with http:// or https://)'
  exit 1
end

puts '=' * 50
puts 'Validation Passed - Configuration Ready'
puts '=' * 50
puts ''
puts "API Key:  #{options['api-key'][0..4]}... (masked)"
puts "Endpoint: #{options['endpoint']}"
puts "Timeout:  #{options[:timeout] || 30} seconds"
puts "Format:   #{options[:format] || :json}"
puts ''
puts 'Ready to make API calls!'
