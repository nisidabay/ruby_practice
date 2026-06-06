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

require "optparse"
require "json"

VERSION = "1.0.0"
PROGRAM = File.basename($0)

config = {
  environment: nil, servers: [], branch: "main",
  dry_run: false, verbose: false, format: :text
}

parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{PROGRAM} <command> [options]"
  opts.separator ""
  opts.separator "Commands:"
  opts.separator "  deploy    Deploy to environment"
  opts.separator "  status    Show deployment status"
  opts.separator ""

  # ── Target ──
  opts.separator "Target:"
  opts.separator "────"
  opts.on("-e", "--environment ENV", %w[dev staging production],
          "Target environment (required for deploy)") { |env| config[:environment] = env }

  opts.on("-s", "--servers S1,S2,S3", Array,
          "Server list") { |s| config[:servers] = s }

  # ── Deployment ──
  opts.separator ""
  opts.separator "Deployment:"
  opts.separator "────"
  opts.on("-b", "--branch BRANCH", "Git branch (default: main)") { |b| config[:branch] = b }
  opts.on("--dry-run", "Simulate, don't execute")                { config[:dry_run] = true }

  # ── Output ──
  opts.separator ""
  opts.separator "Output:"
  opts.separator "────"
  opts.on("--json", "JSON output")        { config[:format] = :json }
  opts.on("--verbose", "Verbose output")  { config[:verbose] = true }

  # ── General ──
  opts.separator ""
  opts.separator "General:"
  opts.separator "────"
  opts.on("-V", "--version", "Show version") { puts "#{PROGRAM} v#{VERSION}"; exit }
  opts.on("-h", "--help", "Show this help")  { puts opts; exit }
end

# ═══════════════════════════
# Parse (with rescue from 05)
# ═══════════════════════════
begin
  parser.parse!
rescue OptionParser::InvalidOption, OptionParser::InvalidArgument,
       OptionParser::MissingArgument => e
  $stderr.puts "Error: #{e.message}"
  $stderr.puts "Try '#{PROGRAM} --help'."
  exit 1
end

command = ARGV.shift

VALID_COMMANDS = %w[deploy status].freeze
unless command && VALID_COMMANDS.include?(command)
  $stderr.puts "Error: Expected one of: #{VALID_COMMANDS.join(', ')}"
  $stderr.puts "Try '#{PROGRAM} --help'."
  exit 1
end

# ═══════════════════════════
# Post-parse validation (from 05)
# ═══════════════════════════
if command == "deploy" && !config[:environment]
  $stderr.puts "Error: --environment is required for deploy"
  exit 1
end

# ═══════════════════════════
# Execute
# ═══════════════════════════
puts "[VERBOSE] Starting #{command}..." if config[:verbose]

result = { command: command, timestamp: Time.now.iso8601 }

case command
when "deploy"
  result[:action]   = "deploying"
  result[:env]      = config[:environment]
  result[:branch]   = config[:branch]
  result[:servers]  = config[:servers]
  result[:dry_run]  = config[:dry_run]

when "status"
  result[:action] = "checking status"
  result[:env]    = config[:environment] || "all"
  # Simulated status data
  result[:servers] = { web1: "healthy", web2: "healthy", db: "healthy" }
end

if config[:format] == :json
  puts JSON.pretty_generate(result)
else
  puts "#{result[:action].capitalize} → #{result[:env]}"
  puts "Branch:  #{result[:branch]}"  if result[:branch]
  puts "Servers: #{result[:servers].join(', ')}" if result[:servers].is_a?(Array) && result[:servers].any?
  puts "[DRY RUN — no changes made]" if config[:dry_run]
  if result[:servers].is_a?(Hash)
    result[:servers].each { |name, status| puts "  #{name}: #{status}" }
  end
end
