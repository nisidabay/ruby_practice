#!/usr/bin/env ruby
# frozen_string_literal: true

# 08_subcommands.rb — Subcommands: the capstone
#
# Builds on everything from 01–07. A real CLI tool with two commands
# (deploy, status), each with its own options, grouped with separators.
#
#   ruby optparse_08_subcommands.rb deploy --environment production --servers web1,web2,web3
#   ruby optparse_08_subcommands.rb deploy --environment staging --dry-run
#   ruby optparse_08_subcommands.rb status --environment dev --json
#   ruby optparse_08_subcommands.rb status           # missing command
#   ruby optparse_08_subcommands.rb -h

require 'optparse'
require 'json'

VERSION = '1.0.0'

# ── Option parsing ──────────────────────────────────────────────────────────

def parse_options(argv)
  options = {
    environment: nil, servers: [], branch: 'main',
    dry_run: false, verbose: false, format: :text
  }

  parser = build_parser(options)
  parser.parse!(argv)
  options
rescue OptionParser::InvalidOption, OptionParser::InvalidArgument,
       OptionParser::MissingArgument => e
  warn "Error: #{e.message}"
  warn "Try '#{File.basename($PROGRAM_NAME)} --help'."
  exit 1
end

def build_parser(options)
  OptionParser.new do |opts|
    opts.banner = "Usage: #{File.basename($PROGRAM_NAME)} <command> [options]"

    add_command_section(opts)
    add_target_options(opts, options)
    add_deployment_options(opts, options)
    add_output_options(opts, options)
    add_general_options(opts)
    add_examples(opts)
  end
end

def add_command_section(opts)
  opts.separator ''
  opts.separator 'Commands:'
  opts.separator '  deploy    Deploy to environment'
  opts.separator '  status    Show deployment status'
end

def add_target_options(opts, options)
  opts.separator 'Target:'
  opts.separator '────'
  opts.on('-e', '--environment ENV', %w[dev staging production],
          'Target environment (required for deploy)') do |env|
    options[:environment] = env
  end
  opts.on('-s', '--servers S1,S2,S3', Array, 'Server list') do |s|
    options[:servers] = s
  end
end

def add_deployment_options(opts, options)
  opts.separator ''
  opts.separator 'Deployment:'
  opts.separator '────'
  opts.on('-b', '--branch BRANCH', 'Git branch (default: main)') { |b| options[:branch] = b }
  opts.on('--dry-run', "Simulate, don't execute")                { options[:dry_run] = true }
end

def add_output_options(opts, options)
  opts.separator ''
  opts.separator 'Output:'
  opts.separator '────'
  opts.on('--json', 'JSON output')       { options[:format] = :json }
  opts.on('--verbose', 'Verbose output') { options[:verbose] = true }
end

def add_general_options(opts)
  opts.separator ''
  opts.separator 'General:'
  opts.separator '────'
  opts.on('-h', '--help', 'Show this help') do
    puts opts
    exit
  end
  opts.on('-V', '--version', 'Show version') do
    puts "#{File.basename($PROGRAM_NAME)} v#{VERSION}"
    exit
  end
end

def add_examples(opts)
  exe = File.basename($PROGRAM_NAME)
  opts.separator ''
  opts.separator 'Examples:'
  opts.separator '────'
  opts.separator "  #{exe} deploy --environment production --servers web1,web2,web3 --branch release/v2"
  opts.separator "  #{exe} deploy -e staging -s web1,web2 --dry-run"
  opts.separator "  #{exe} deploy -e dev -b hotfix --verbose"
  opts.separator "  #{exe} status --environment production --json"
  opts.separator "  #{exe} status -e dev --json --verbose"
  opts.separator "  #{exe} status --verbose"
  opts.separator "  #{exe} --version"
end

# ── Command dispatch ────────────────────────────────────────────────────────

def extract_command(argv)
  command = argv.shift

  unless command && %w[deploy status].include?(command)
    warn 'Error: Expected one of: deploy, status'
    warn "Try '#{File.basename($PROGRAM_NAME)} --help'."
    exit 1
  end

  command
end

def validate_command(command, options)
  return unless command == 'deploy' && !options[:environment]

  warn 'Error: --environment is required for deploy'
  exit 1
end

# ── Command handlers ────────────────────────────────────────────────────────

def run_deploy(options)
  {
    command: 'deploy',
    action: 'deploying',
    env: options[:environment],
    branch: options[:branch],
    servers: options[:servers],
    dry_run: options[:dry_run],
    timestamp: Time.now.iso8601
  }
end

def run_status(options)
  {
    command: 'status',
    action: 'checking status',
    env: options[:environment] || 'all',
    servers: { web1: 'healthy', web2: 'healthy', db: 'healthy' },
    timestamp: Time.now.iso8601
  }
end

# ── Output formatting ───────────────────────────────────────────────────────

def format_result(result, options)
  if options[:format] == :json
    puts JSON.pretty_generate(result)
  else
    format_text(result, options)
  end
end

def format_text(result, options)
  puts "[VERBOSE] Starting #{result[:command]}..." if options[:verbose]
  puts "#{result[:action].capitalize} → #{result[:env]}"
  puts "Branch:  #{result[:branch]}" if result[:branch]
  puts "Servers: #{result[:servers].join(', ')}" if result[:servers].is_a?(Array) && result[:servers].any?
  puts '[DRY RUN — no changes made]' if result[:dry_run]
  result[:servers].each { |name, status| puts "  #{name}: #{status}" } if result[:servers].is_a?(Hash)
end

# ── Main ────────────────────────────────────────────────────────────────────

def main(argv = ARGV)
  options = parse_options(argv)
  command = extract_command(argv)
  validate_command(command, options)

  result = case command
           when 'deploy' then run_deploy(options)
           when 'status' then run_status(options)
           end

  format_result(result, options)
end

main if $PROGRAM_NAME == __FILE__
