#!/usr/bin/env ruby
# 03_type_conversion.rb - Automatic type conversion
# Run: ruby 03_type_conversion.rb -h
#      ruby 03_type_conversion.rb -p 8080 -r 3.14 -c 10
#      ruby 03_type_conversion.rb --port 3000 --rate 2.5 --count 5
#      ruby 03_type_conversion.rb -t ruby -t python -t javascript

require 'optparse'

options = {
  port: 8080,
  rate: 1.0,
  count: 1,
  tags: [],
  ids: [],
  format: nil,
  wait: nil
}

OptionParser.new do |opts|
  opts.banner = 'Usage: 03_type_conversion.rb [options]'
  opts.separator ''
  opts.separator 'Type conversion - OptionParser automatically converts types'
  opts.separator ''

  # Integer conversion
  opts.on('-p', '--port PORT', Integer, 'Port number (default: 8080)') do |port|
    options[:port] = port
  end

  # Float conversion
  opts.on('-r', '--rate RATE', Float, 'Rate value (default: 1.0)') do |rate|
    options[:rate] = rate
  end

  # Integer with validation in block
  opts.on('-c', '--count COUNT', Integer, 'Number of items (default: 1)') do |count|
    raise OptionParser::InvalidArgument, 'Count cannot be negative' if count < 0

    options[:count] = count
  end

  # Array - collect multiple values
  opts.on('-t', '--tag TAG', Array, 'Tags (can specify multiple times)') do |tags|
    options[:tags] += tags
  end

  # Array with comma-separated values
  opts.on('-i', '--ids ID1,ID2,ID3', Array, 'Comma-separated IDs') do |ids|
    options[:ids] = ids
  end

  # Restricted values - must match one of the array
  opts.on('-f', '--format FORMAT', %w[json xml yaml csv],
          'Output format (json/xml/yaml/csv)') do |format|
    options[:format] = format
  end

  # Optional integer
  opts.on('-w', '--wait [SECONDS]', Integer, 'Wait time in seconds') do |seconds|
    raise OptionParser::InvalidArgument, 'Wait cannot be negative' if seconds < 0

    options[:wait] = seconds || 0
  end

  opts.on('-h', '--help', 'Show this help message') do
    puts opts
    exit
  end
end.parse!

# Demonstrate the results
puts '=' * 50
puts 'Parsed Options with Type Conversion'
puts '=' * 50
puts ''

puts "Port:  #{options[:port]} (class: #{options[:port].class})"
puts "Rate:  #{options[:rate]} (class: #{options[:rate].class})"
puts "Count: #{options[:count]} (class: #{options[:count].class})"
puts ''

puts "Tags:  #{options[:tags].inspect}"
puts "IDs:   #{options[:ids].inspect}"
puts "Format: #{options[:format] || '(not specified)'}"
puts "Wait:  #{options[:wait]} seconds"
puts ''

# Demonstrate type safety
puts '=' * 50
puts 'Type Safety Demonstration'
puts '=' * 50

# These work because OptionParser already converted the types
if options[:port] > 1024
  puts "✓ Port #{options[:port]} is a user port (>1024)"
else
  puts "✓ Port #{options[:port]} is a system port (<=1024)"
end

if options[:rate] > 1.0
  puts "✓ Rate #{options[:rate]} is above default"
elsif options[:rate] < 1.0
  puts "✓ Rate #{options[:rate]} is below default"
else
  puts '✓ Rate is at default (1.0)'
end

# Array operations work directly
if options[:tags].any?
  puts "✓ Tags provided: #{options[:tags].join(', ')}"
else
  puts '✓ No tags specified'
end

puts ''
puts 'All values are properly typed - no manual conversion needed!'
