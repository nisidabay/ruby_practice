#!/usr/bin/env ruby
# 06_advanced_features.rb - Separators, version, complex setups
# Run: ruby 06_advanced_features.rb -h
#      ruby 06_advanced_features.rb -V
#      ruby 06_advanced_features.rb --host localhost --port 3000 --verbose

require 'optparse'

VERSION = "1.0.0"
APP_NAME = "Advanced CLI"

options = {
  verbose: false,
  quiet: false,
  host: 'localhost',
  port: 8080,
  bind: nil,
  ssl: false,
  cert: nil,
  key: nil,
  config: nil
}

OptionParser.new do |opts|
  # Custom banner with version
  opts.banner = <<-BANNER
Usage: #{File.basename($0)} [options] <command>

#{APP_NAME} v#{VERSION} - Advanced OptionParser features demo

Commands:
  start     Start the server
  stop      Stop the server  
  restart   Restart the server
  status    Show server status

BANNER

  opts.separator "Basic Options:"
  opts.separator "─" * 40
  
  opts.on("-v", "--verbose", "Enable verbose output") do
    options[:verbose] = true
  end
  
  opts.on("-q", "--quiet", "Suppress non-error output") do
    options[:quiet] = true
  end
  
  opts.separator ""
  opts.separator "Server Configuration:"
  opts.separator "─" * 40
  
  opts.on("-h", "--host HOST", String, "Server hostname (default: localhost)") do |host|
    options[:host] = host
  end
  
  opts.on("-p", "--port PORT", Integer, "Server port (default: 8080)") do |port|
    options[:port] = port
  end
  
  opts.on("-b", "--bind ADDRESS", "Bind to specific address") do |addr|
    options[:bind] = addr
  end
  
  opts.separator ""
  opts.separator "SSL/TLS Options:"
  opts.separator "─" * 40
  
  opts.on("--ssl", "Enable SSL/TLS") do
    options[:ssl] = true
  end
  
  opts.on("--cert FILE", "SSL certificate file") do |file|
    options[:cert] = file
  end
  
  opts.on("--key FILE", "SSL private key file") do |file|
    options[:key] = file
  end
  
  opts.separator ""
  opts.separator "General Options:"
  opts.separator "─" * 40
  
  opts.on("-c", "--config FILE", "Load configuration from file") do |file|
    options[:config] = file
  end
  
  opts.on("-V", "--version", "Show version information") do
    puts "#{APP_NAME} version #{VERSION}"
    exit
  end
  
  opts.on("-H", "--help", "Show this help message") do
    puts opts
    exit
  end
  
  # Custom footer
  opts.separator ""
  opts.separator "Examples:"
  opts.separator "  #{File.basename($0)} start --port 3000 --verbose"
  opts.separator "  #{File.basename($0)} stop --host production.example.com"
  opts.separator "  #{File.basename($0)} --ssl --cert server.crt --key server.key"
  opts.separator ""
  opts.separator "Report bugs to: bugs@example.com"
end.parse!

# Get the command (first non-option argument)
command = ARGV.shift

# Demonstrate the results
puts "=" * 50
puts "#{APP_NAME} v#{VERSION}"
puts "=" * 50
puts ""

if command
  puts "Command: #{command}"
else
  puts "Command: (none provided)"
  puts "  Run with 'start', 'stop', 'restart', or 'status'"
end

puts ""
puts "Configuration:"
puts "  Host:     #{options[:host]}"
puts "  Port:     #{options[:port]}"
puts "  Verbose:  #{options[:verbose]}"
puts "  Quiet:    #{options[:quiet]}"
puts "  SSL:      #{options[:ssl]}"
puts "  Cert:     #{options[:cert] || '(not set)'}"
puts "  Key:      #{options[:key] || '(not set)'}"
puts "  Config:   #{options[:config] || '(not set)'}"
puts ""

# Validate SSL options
if options[:ssl]
  if !options[:cert] || !options[:key]
    puts "Warning: SSL enabled but certificate or key not specified"
  end
end

puts "Ready to execute command: #{command || 'none'}"
