#!/usr/bin/env ruby
# 05_custom_validation.rb - Custom validators and error handling
# Run: ruby 05_custom_validation.rb -h
#      ruby 05_custom_validation.rb -p 8080 -e production
#      ruby 05_custom_validation.rb --port 443 --env staging --log-level debug

require 'optparse'

options = {
  port: nil,
  env: nil,
  log_level: 'info',
  date: nil,
  config: nil
}

OptionParser.new do |opts|
  opts.banner = "Usage: 05_custom_validation.rb [options]"
  opts.separator ""
  opts.separator "Custom validation - validate arguments with your own logic"
  opts.separator ""
  
  # Custom port validation
  opts.on("-p", "--port PORT", "Port number (1-65535)") do |port_str|
    begin
      port = Integer(port_str)
      if port < 1 || port > 65535
        raise OptionParser::InvalidArgument, 
              "Port must be between 1 and 65535, got #{port}"
      end
      options[:port] = port
    rescue ArgumentError
      raise OptionParser::InvalidArgument, 
            "Invalid port number: #{port_str}"
    end
  end
  
  # Custom environment validation
  opts.on("-e", "--env ENV", "Environment (dev/staging/prod)") do |env|
    valid_envs = %w[dev staging production prod]
    unless valid_envs.include?(env.downcase)
      raise OptionParser::InvalidArgument,
            "Invalid environment '#{env}'. Must be one of: #{valid_envs.join(', ')}"
    end
    options[:env] = env.downcase
  end
  
  # Custom log level with numeric validation
  opts.on("-l", "--log-level LEVEL", "Log level (debug/info/warn/error)") do |level|
    valid_levels = %w[debug info warn error]
    unless valid_levels.include?(level.downcase)
      raise OptionParser::InvalidArgument,
            "Invalid log level '#{level}'. Must be one of: #{valid_levels.join(', ')}"
    end
    options[:log_level] = level.downcase
  end
  
  # Custom date validation
  opts.on("--date DATE", "Date in YYYY-MM-DD format") do |date_str|
    if date_str !~ /^\d{4}-\d{2}-\d{2}$/
      raise OptionParser::InvalidArgument,
            "Date must be in YYYY-MM-DD format, got: #{date_str}"
    end
    
    begin
      Date.parse(date_str)
      options[:date] = date_str
    rescue ArgumentError
      raise OptionParser::InvalidArgument,
            "Invalid date: #{date_str}"
    end
  end
  
  # Custom file path validation
  opts.on("--config FILE", "Configuration file path") do |file|
    unless File.exist?(file)
      raise OptionParser::InvalidArgument,
            "Config file not found: #{file}"
    end
    unless File.readable?(file)
      raise OptionParser::InvalidArgument,
            "Config file not readable: #{file}"
    end
    options[:config] = file
  end
  
  opts.separator ""
  opts.separator "Examples:"
  opts.separator "  ruby 05_custom_validation.rb --port 8080 --env production"
  opts.separator "  ruby 05_custom_validation.rb -p 443 -e dev -l debug"
  opts.separator ""
  
  opts.on("-h", "--help", "Show this help message") do
    puts opts
    exit
  end
end.parse!

# Demonstrate successful validation
require 'date'

puts "=" * 50
puts "Custom Validation Passed"
puts "=" * 50
puts ""
puts "Port:      #{options[:port]}"
puts "Environment: #{options[:env] || '(not specified)'}"
puts "Log Level: #{options[:log_level]}"
puts "Date:      #{options[:date] || '(not specified)'}"
puts "Config:    #{options[:config] || '(not specified)'}"
puts ""
puts "All custom validations succeeded!"
