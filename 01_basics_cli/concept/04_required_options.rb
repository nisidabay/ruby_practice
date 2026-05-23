#!/usr/bin/env ruby
# 04_required_options.rb - Application-level required options vs OptionParser-level required arguments
# Run: ruby 04_required_options.rb -h
#      ruby 04_required_options.rb --api-key abc123
#      ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com
#
# TWO DISTINCT CONCEPTS:
#   1. OptionParser level: --api-key KEY  → OptionParser demands KEY (won't parse without it)
#   2. Application level:  we reject the program if --api-key wasn't provided at all
#
# OptionParser CAN'T enforce #2 — it doesn't know which options your app "requires."
# That's why we validate after parsing.

require 'optparse'

# Every option your program uses lives here with its default.
# This is the single source of truth for "what config shape does this program have?"
# The OptionParser block only fills in values the user passed — it never invents new keys.
options = {
  api_key: nil,
  endpoint: nil,
  timeout: nil,
  format: nil
}

OptionParser.new do |opts|
  opts.banner = 'Usage: 04_required_options.rb [options]'
  opts.separator ''
  opts.separator 'Required options and validation patterns'
  opts.separator ''
  opts.separator '  --api-key KEY    ← OptionParser REQUIRES the argument KEY (uppercase = mandatory value)'
  opts.separator '  --timeout [SECS] ← brackets = argument is optional'
  opts.separator '  --json           ← no argument at all (boolean flag)'
  opts.separator ''
  opts.separator "  Application-level \"required\": we check after parsing that --api-key"
  opts.separator '  was actually passed. OptionParser can only enforce that IF you pass'
  opts.separator '  --api-key, it must have a value — not that it was passed at all.'

  opts.separator ''

  # KEY (uppercase) → OptionParser requires the argument. Without --api-key,
  # OptionParser won't complain — we validate that below.
  opts.on('--api-key KEY', 'API key (app-required — validated after parsing)') do |key|
    options[:api_key] = key
  end

  # Same: URL is the required argument to --endpoint (uppercase)
  opts.on('--endpoint URL', 'API endpoint URL (app-required)') do |url|
    options[:endpoint] = url
  end

  # Integer type coerces SECONDS to Integer. Uppercase = OptionParser demands value.
  # (This is NOT application-required — we don't reject if it's missing.)
  opts.on('--timeout SECONDS', Integer, 'Request timeout in seconds') do |timeout|
    options[:timeout] = timeout
  end

  # Boolean flags: no value placeholder, just --json or --xml
  opts.on('--json', 'Output in JSON format') do
    options[:format] = :json
  end

  opts.on('--xml', 'Output in XML format') do
    options[:format] = :xml
  end

  opts.separator ''
  opts.separator 'Examples:'
  opts.separator '  ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com'
  opts.separator '  ruby 04_required_options.rb --api-key abc123 --endpoint https://api.example.com --timeout 30'
  opts.separator ''

  opts.on('-h', '--help', 'Show this help message') do
    puts opts
    exit
  end
end.parse!

# Validation: Check required options
required = %i[api_key endpoint]
missing = required.reject { |key| options.key?(key) }

if missing.any?
  puts 'Error: Missing required options:'
  missing.each do |opt|
    puts "  --#{opt.to_s.gsub('_', '-')}"
  end
  puts ''
  puts 'Try --help for usage information'
  exit 1
end

# Validation: Check mutually exclusive options
if options[:format] == :json && options[:xml]
  puts 'Error: Cannot use both --json and --xml'
  exit 1
end

# Validation: Check dependent options
if options[:timeout] && options[:timeout] <= 0
  puts 'Error: Timeout must be a positive number'
  exit 1
end

# Validation: URL format (basic check)
if options[:endpoint] && !options[:endpoint].start_with?('http')
  puts 'Error: Endpoint must be a valid URL (start with http:// or https://)'
  exit 1
end

# All validations passed - demonstrate usage
puts '=' * 50
puts 'Validation Passed - Configuration Ready'
puts '=' * 50
puts ''
puts "API Key:  #{options[:api_key][0..4]}..." # Mask most of the key
puts "Endpoint: #{options[:endpoint]}"
puts "Timeout:  #{options[:timeout] || 30} seconds"
puts "Format:   #{options[:format] || :json}"
puts ''
puts 'Ready to make API calls!'
