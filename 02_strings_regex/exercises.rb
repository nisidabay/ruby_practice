#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Real-world regex problems: log parsing, validation, data extraction

# Exercise 1: Parse log lines — extract timestamp, severity, and message
# Input: A syslog-style log line
log_line = 'Jun 25 10:42:13 myhost sshd[1234]: Failed password for root from 10.0.0.1 port 22'

# Extract: date components, program, message, and IP
match = log_line.match(/(\w+\s+\d+\s+\d{2}:\d{2}:\d{2})\s+\S+\s+(\S+)\[(\d+)\]:\s+(.+)/)
if match
  timestamp = match[1]
  process   = match[2]
  pid       = match[3]
  message   = match[4]
  puts "1) Timestamp: #{timestamp}, Process: #{process}[#{pid}], Message: #{message}"
end

# Extract IP using a named capture
ip_match = log_line.match(/(?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/)
puts "   IP: #{ip_match[:ip]}" if ip_match

# Exercise 2: Validate and normalize phone numbers
# Accept: (555) 123-4567, 555-123-4567, 5551234567
phones = ['(555) 123-4567', '555-123-4567', '5551234567', '12-34']

phones.each do |phone|
  normalized = phone.gsub(/[^\d]/, '')  # strip everything non-digit
  if normalized =~ /\A\d{10}\z/
    # Format as (555) 123-4567
    formatted = normalized.gsub(/(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3')
    puts "2) #{phone.ljust(20)} -> #{formatted}"
  else
    puts "2) #{phone.ljust(20)} -> INVALID (#{normalized.length} digits)"
  end
end

# Exercise 3: Extract all URLs from a config file
config = <<~CONFIG
  server: https://api.example.com/v2
  backup: sftp://backup.internal
  docs: http://docs.example.com
CONFIG

# Extract protocol and hostname from each URL
config.scan(/(\w+):\/\/([^\s\/]+)/) do |protocol, host|
  puts "3) Protocol: #{protocol}, Host: #{host}"
end

# Exercise 4: Find words NOT followed by punctuation (negative lookahead)
text = 'Hello, world! How are you? Fine. Thanks.'

# Match words that are NOT followed by punctuation (word boundary + negative lookahead)
words = text.scan(/\b\w+\b(?![\.,!?;:])/)
puts "4) Words not before punctuation: #{words}"
# => ["How", "are"] — "Hello,", "world!", "you?", "Fine.", "Thanks." all before punctuation

# Exercise 5: Parse CSV-like data (non-capturing groups in action)
data = 'apple,fruit,red;carrot,vegetable,orange;banana,fruit,yellow'

# Extract only fruit entries using scan with non-capturing group for the delimiter
data.split(';').each do |entry|
  fields = entry.split(',')
  name, type, color = fields
  next unless type == 'fruit'
  puts "5) Fruit: #{name} (#{color})"
end

# Alternative with regex (using non-capturing group for the whole-pattern grouping):
data.scan(/(\w+),(?:fruit),(\w+)/) do |name, color|
  puts "   (regex) Fruit: #{name} (#{color})"
end
