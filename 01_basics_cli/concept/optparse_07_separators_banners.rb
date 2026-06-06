#!/usr/bin/env ruby
# frozen_string_literal: true

# 07_separators_banners.rb — Grouping options with separators and banners
#
# You've defined 8 options in one flat list. Here's how to organize them
# into logical groups so --help looks like a real tool's man page.
#
#   ruby optparse_07_separators_banners.rb -h
#   ruby optparse_07_separators_banners.rb -V
#   ruby optparse_07_separators_banners.rb --host 0.0.0.0 --port 3000 --verbose

require "optparse"

VERSION  = "1.0.0"
APP_NAME = "ServerCLI"
program  = File.basename($0)

options = { host: "localhost", port: 8080, verbose: false, ssl: false,
            cert: nil, key: nil, config: nil }

OptionParser.new do |opts|
  opts.banner = <<~BANNER
    Usage: #{program} [options]

    #{APP_NAME} v#{VERSION} — demonstration of option grouping

  BANNER

  # ── Basic Options ──
  opts.separator "Basic Options:"
  opts.separator "────"

  opts.on("-v", "--verbose", "Verbose output") do
    options[:verbose] = true
  end

  opts.on("-q", "--quiet", "Suppress non-error output") do
    options[:quiet] = true
  end

  # ── Server Configuration ──
  opts.separator ""
  opts.separator "Server Configuration:"
  opts.separator "────"

  opts.on("--host HOST", "Server hostname (default: localhost)") do |h|
    options[:host] = h
  end

  opts.on("-p", "--port PORT", Integer, "Server port (default: 8080)") do |p|
    options[:port] = p
  end

  # ── SSL/TLS ──
  opts.separator ""
  opts.separator "SSL/TLS:"
  opts.separator "────"

  opts.on("--ssl", "Enable SSL/TLS") do
    options[:ssl] = true
  end

  opts.on("--cert FILE", "SSL certificate") { |f| options[:cert] = f }
  opts.on("--key FILE",  "SSL private key") { |f| options[:key]  = f }

  # ── General ──
  opts.separator ""
  opts.separator "General:"
  opts.separator "────"

  opts.on("-c", "--config FILE", "Load config from file") { |f| options[:config] = f }

  opts.on("-V", "--version", "Show version") do
    puts "#{APP_NAME} v#{VERSION}"
    exit
  end

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end

  # Footer
  opts.separator ""
  opts.separator "Examples:"
  opts.separator "  #{program} --port 3000 --verbose"
  opts.separator "  #{program} --ssl --cert server.crt --key server.key"
end.parse!

puts "#{APP_NAME} v#{VERSION}"
puts "Host:    #{options[:host]}"
puts "Port:    #{options[:port]}"
puts "Verbose: #{options[:verbose]}"
puts "SSL:     #{options[:ssl]}"
puts "Cert:    #{options[:cert] || '(not set)'}"
puts "Key:     #{options[:key]  || '(not set)'}"
