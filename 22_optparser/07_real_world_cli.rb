#!/usr/bin/env ruby
# 07_real_world_cli.rb - Complete CLI application example
# A mock deployment tool demonstrating all OptionParser features
#
# Run: ruby 07_real_world_cli.rb -h
#      ruby 07_real_world_cli.rb deploy production --servers web1,web2 --verbose
#      ruby 07_real_world_cli.rb rollback --version 1.2.3
#      ruby 07_real_world_cli.rb status --environment staging

require 'optparse'
require 'json'

# Application constants
APP_NAME = "DeployCLI"
VERSION = "2.1.0"

# Default configuration
config = {
  verbose: false,
  quiet: false,
  timeout: 300,
  environment: nil,
  servers: [],
  version: nil,
  dry_run: false,
  format: 'text'
}

# Parse command-line options
OptionParser.new do |opts|
  opts.banner = <<-BANNER
Usage: #{File.basename($0)} <command> [options]

#{APP_NAME} v#{VERSION} - Deployment automation tool

Commands:
  deploy      Deploy application to servers
  rollback    Rollback to a previous version
  status      Show deployment status
  logs        Fetch deployment logs

BANNER

  opts.separator "Target Options:"
  opts.separator "─" * 50
  
  opts.on("-e", "--environment ENV", [:dev, :staging, :production], 
                       "Target environment (required for deploy)") do |env|
    config[:environment] = env
  end
  
  opts.on("-s", "--servers SERVER1,SERVER2", Array, 
                       "Comma-separated server list") do |servers|
    config[:servers] = servers
  end
  
  opts.on("--all-servers", "Deploy to all servers in environment") do
    config[:all_servers] = true
  end
  
  opts.separator ""
  opts.separator "Deployment Options:"
  opts.separator "─" * 50
  
  opts.on("-v", "--version VER", "Version to deploy/rollback") do |ver|
    config[:version] = ver
  end
  
  opts.on("-b", "--branch BRANCH", "Git branch to deploy (default: main)") do |branch|
    config[:branch] = branch
  end
  
  opts.on("--dry-run", "Simulate deployment without changes") do
    config[:dry_run] = true
  end
  
  opts.on("-t", "--timeout SECONDS", Integer, 
                       "Operation timeout in seconds (default: 300)") do |secs|
    config[:timeout] = secs
  end
  
  opts.separator ""
  opts.separator "Output Options:"
  opts.separator "─" * 50
  
  opts.on("--json", "Output in JSON format") do
    config[:format] = :json
  end
  
  opts.on("--verbose", "Enable verbose output") do
    config[:verbose] = true
  end
  
  opts.on("-q", "--quiet", "Suppress non-essential output") do
    config[:quiet] = true
  end
  
  opts.separator ""
  opts.separator "Authentication:"
  opts.separator "─" * 50
  
  opts.on("--api-key KEY", "API key for deployment service") do |key|
    config[:api_key] = key
  end
  
  opts.on("--token TOKEN", "OAuth token for authentication") do |token|
    config[:token] = token
  end
  
  opts.separator ""
  opts.separator "General Options:"
  opts.separator "─" * 50
  
  opts.on("-c", "--config FILE", "Load configuration from YAML file") do |file|
    config[:config_file] = file
  end
  
  opts.on("-V", "--version", "Show version information") do
    puts "#{APP_NAME} version #{VERSION}"
    exit
  end
  
  opts.on("-H", "--help", "Show this help message") do
    puts opts
    exit
  end
  
  opts.separator ""
  opts.separator "Examples:"
  opts.separator "  #{File.basename($0)} deploy --environment production --servers web1,web2,web3"
  opts.separator "  #{File.basename($0)} deploy --environment staging --branch feature/new-ui --dry-run"
  opts.separator "  #{File.basename($0)} rollback --version 1.2.3 --environment production"
  opts.separator "  #{File.basename($0)} status --environment dev --json"
  opts.separator ""
  opts.separator "Documentation: https://docs.example.com/deploycli"
  opts.separator "Support: support@example.com"
end.parse!

# Get command from remaining arguments
command = ARGV.shift

# Validation functions
def validate_command(command)
  valid_commands = %w[deploy rollback status logs]
  unless valid_commands.include?(command)
    puts "Error: Unknown command '#{command}'"
    puts "Valid commands: #{valid_commands.join(', ')}"
    exit 1
  end
end

def validate_deploy_config(config)
  errors = []
  
  unless config[:environment]
    errors << "--environment is required for deploy"
  end
  
  if config[:servers].empty? && !config[:all_servers]
    errors << "Specify --servers or --all-servers"
  end
  
  if config[:dry_run] && config[:verbose]
    puts "[DRY RUN] Would validate deployment configuration"
  end
  
  unless errors.empty?
    puts "Deployment validation failed:"
    errors.each { |e| puts "  - #{e}" }
    exit 1
  end
end

def validate_auth(config)
  unless config[:api_key] || config[:token]
    puts "Warning: No authentication provided (--api-key or --token)"
    puts "  Some operations may fail without authentication"
  end
end

# Output formatting
def output_result(data, format)
  case format
  when :json
    puts JSON.pretty_generate(data)
  else
    data.each do |key, value|
      puts "#{key.to_s.rjust(15)}: #{value}"
    end
  end
end

# Main execution
if config[:verbose] && !config[:quiet]
  puts "[VERBOSE] Starting #{APP_NAME} v#{VERSION}"
  puts "[VERBOSE] Command: #{command || 'none'}"
  puts "[VERBOSE] Environment: #{config[:environment] || 'not specified'}"
end

# Validate command
if command
  validate_command(command)
else
  puts "Error: No command specified"
  puts "Run with --help for usage information"
  exit 1
end

# Command-specific validation
validate_deploy_config(config) if command == 'deploy'
validate_auth(config)

# Simulate command execution
puts ""
puts "=" * 50
puts "#{APP_NAME} - Execution Summary"
puts "=" * 50
puts ""

result = {
  app: APP_NAME,
  version: VERSION,
  command: command,
  timestamp: Time.now.iso8601,
  config: config.reject { |k, v| [:api_key, :token].include?(k) } # Don't show secrets
}

if config[:dry_run]
  result[:dry_run] = true
  puts "[DRY RUN MODE - No changes will be made]"
  puts ""
end

case command
when 'deploy'
  result[:action] = "Deploying to #{config[:environment]}"
  result[:targets] = config[:servers]
  result[:branch] = config[:branch] || 'main'
  puts "Deploying to: #{config[:environment]}"
  puts "Servers: #{config[:servers].join(', ')}"
  puts "Branch: #{config[:branch] || 'main'}"
  
when 'rollback'
  result[:action] = "Rolling back to version #{config[:version]}"
  puts "Rolling back to version: #{config[:version] || 'previous'}"
  
when 'status'
  result[:action] = "Checking status"
  puts "Checking deployment status..."
  
when 'logs'
  result[:action] = "Fetching logs"
  puts "Fetching deployment logs..."
end

puts ""
if config[:format] == :json
  puts "Full result (JSON):"
  output_result(result, :json)
else
  puts "Configuration:"
  output_result(result[:config].reject { |k, v| v.nil? || (v.is_a?(Array) && v.empty?) }, :text)
end

puts ""
puts "✓ Command completed successfully"
