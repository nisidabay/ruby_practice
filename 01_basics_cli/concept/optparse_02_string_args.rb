#!/usr/bin/env ruby
# 02_string_args.rb - Options that take arguments vs flags
# Run: ruby 02_string_args.rb -h
#      ruby 02_string_args.rb -n "Alice"
#      ruby 02_string_args.rb --name "Bob" --email "bob@example.com"
#      ruby 02_string_args.rb -n "Charlie" -e "charlie@test.com" -o output.txt

require 'optparse'

options = {
  name: nil,
  email: nil,
  output: 'stdout',
  message: nil
}

OptionParser.new do |opts|
  opts.banner = 'Usage: 02_string_args.rb [options]'
  opts.separator ''
  opts.separator 'Options that take a value (vs boolean flags in 01_basic_flags.rb)'
  opts.separator "  --name NAME  →  OptionParser requires the argument ('NAME' is the value placeholder)"
  opts.separator "  --output [FILE] → brackets make the argument optional"

  opts.separator ''

  # NAME (uppercase) signals OptionParser that this option REQUIRES a value
  # If you pass --name without a value, OptionParser errors immediately
  opts.on('-n', '--name NAME', "User's name") do |name|
    options[:name] = name
  end

  # Same pattern: EMAIL is the value placeholder, OptionParser demands it
  opts.on('-e', '--email EMAIL', 'Email address') do |email|
    options[:email] = email
  end

  # Optional string argument (note the brackets around FILE)
  opts.on('-o', '--output [FILE]', 'Output file (default: stdout)') do |file|
    options[:output] = file || 'stdout'
  end

  # Long description spanning multiple lines
  opts.on('-m', '--message MSG', 'Custom message to display',
          'Can be multiple lines',
          "Default: 'Hello, World!'") do |msg|
    options[:message] = msg
  end
end.parse!

# Validation: check required options
if options[:name].nil?
  puts 'Error: --name is required'
  puts ''
  puts 'Try --help for usage information'
  exit 1
end

# Demonstrate the results
puts '=' * 50
puts 'Parsed Options:'
puts '=' * 50
puts "Name:   #{options[:name]}"
puts "Email:  #{options[:email] || '(not provided)'}"
puts "Output: #{options[:output]}"
puts "Message: #{options[:message] || 'Hello, World!'}"
puts '=' * 50

# Practical usage example
message = options[:message] || 'Hello, World!'
greeting = "Hello, #{options[:name]}!"

if options[:output] == 'stdout'
  puts ''
  puts greeting
  puts message
else
  File.write(options[:output], "#{greeting}\n#{message}\n")
  puts "Written to: #{options[:output]}"
end

if options[:email]
  puts "Would send email to:
  #{options[:email]}"
end
