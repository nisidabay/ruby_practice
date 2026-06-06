#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_string_args.rb — Options that take a value (vs boolean flags in 01)
#
# In 01 the block received nothing (boolean toggle).
# Here the block receives the VALUE the user typed after the flag.
#
#   ruby optparse_03_string_args.rb -n Alice -e alice@example.com
#   ruby optparse_03_string_args.rb --name Bob --email bob@test.com -o out.txt
#   ruby optparse_03_string_args.rb -h

require "optparse"

options = { name: nil, email: nil, output: "stdout" }

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  # --name NAME  →  "NAME" is the value placeholder (shown in help)
  opts.on("-n", "--name NAME", "Your name") do |name|
    options[:name] = name
  end

  opts.on("-e", "--email EMAIL", "Email address") do |email|
    options[:email] = email
  end

  # Brackets around [FILE] make the argument OPTIONAL
  opts.on("-o", "--output [FILE]", "Output file (default: stdout)") do |file|
    options[:output] = file || "stdout"
  end

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end
end.parse!

# Required-option check (preview of what 05 formalizes)
if options[:name].nil?
  $stderr.puts "Error: --name is required"
  exit 1
end

if options[:email].nil?
  $stderr.puts "Error: --email is required"
  exit 1
end

puts "Name:    #{options[:name]}"
puts "Email:   #{options[:email]}"
puts "Output:  #{options[:output]}"
puts

greeting = "Hello, #{options[:name]}!"
if options[:output] == "stdout"
  puts greeting
  puts "Would send to: #{options[:email]}"
else
  File.write(options[:output], "#{greeting}\nWould send to: #{options[:email]}\n")
  puts "Written to: #{options[:output]}"
end
