# frozen_string_literal: true

# 04_type_conversion.rb — OptionParser auto-converts arguments to types
#
# In 03, the block got a String. Here, OptionParser does the conversion
# BEFORE the block runs: Integer, Float.
#
#   ruby optparse_04_type_conversion.rb -p 8080 -r 2.5
#   ruby optparse_04_type_conversion.rb --port 3000 --rate 1.0 --count 3
#   ruby optparse_04_type_conversion.rb -h

require 'optparse'

options = { port: 8080, rate: 1.0, count: 1 }

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]"

  # Pass Integer as the 3rd argument → block receives an Integer, not a String
  opts.on('-p', '--port PORT', Integer, 'Port number (default: 8080)') do |port|
    options[:port] = port
  end

  opts.on('-r', '--rate RATE', Float, 'Rate value (default: 1.0)') do |rate|
    options[:rate] = rate
  end

  opts.on('-c', '--count COUNT', Integer, 'Number of items (default: 1)') do |count|
    options[:count] = count
  end

  opts.on('-h', '--help', 'Show this help') do
    puts opts
    exit
  end
end.parse!

puts "Port:  #{options[:port]}   (#{options[:port].class})"
puts "Rate:  #{options[:rate]}   (#{options[:rate].class})"
puts "Count: #{options[:count]}   (#{options[:count].class})"
puts

# These comparisons work because OptionParser already converted the types
puts "Port #{options[:port]} > 1024? #{options[:port] > 1024}"
puts "Rate #{options[:rate]} > 1.0? #{options[:rate] > 1.0}"
