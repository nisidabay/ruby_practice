#!/usr/bin/env ruby
# frozen_string_literal: true

# 08_subcommands.rb — Subcommands: the capstone
#
# Builds on everything from 01–07. A real CLI tool with three commands
# (download, info, list-formats), each with its own options, grouped with separators.
#
#   ruby optparse_08_subcommands.rb download --url https://youtube.com/watch?v=xyz --format mp4 --verbose
#   ruby optparse_08_subcommands.rb info --url https://youtube.com/watch?v=abc
#   ruby optparse_08_subcommands.rb list-formats --url https://youtube.com/watch?v=xyz
#   ruby optparse_08_subcommands.rb -h
#   ruby optparse_08_subcommands.rb --version

require 'optparse'
require 'json'

VERSION = '1.0.0'

# ── Option parsing ──────────────────────────────────────────────────────────

def parse_options(argv)
  options = {
    url: nil, format: nil, quality: nil, output: nil,
    concurrent_downloads: 3, dry_run: false, verbose: false, json: false
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
    add_download_options(opts, options)
    add_output_options(opts, options)
    add_general_options(opts)
    add_examples(opts)
  end
end

def add_command_section(opts)
  opts.separator ''
  opts.separator 'Commands:'
  opts.separator '  download    Download video'
  opts.separator '  info        Show video info'
  opts.separator '  list-formats    List available formats'
end

def add_target_options(opts, options)
  opts.separator 'Target:'
  opts.separator '────'
  opts.on('-u', '--url URL', 'Video URL (required for download/info)') do |url|
    options[:url] = url
  end
  opts.on('-f', '--format FORMAT', %w[mp3 mp4 mkv],
          'Output format (required for download)') do |fmt|
    options[:format] = fmt
  end
  opts.on('-q', '--quality QUALITY', %w[low medium high best],
          'Video quality (default: best)') do |q|
    options[:quality] = q
  end
end

def add_download_options(opts, options)
  opts.separator ''
  opts.separator 'Download:'
  opts.separator '────'
  opts.on('-c', '--concurrent-downloads N', Integer, 'Concurrent downloads (default: 3)') { |n|
    options[:concurrent_downloads] = n
  }
  opts.on('--dry-run', 'Simulate, don\'t download') { options[:dry_run] = true }
end

def add_output_options(opts, options)
  opts.separator ''
  opts.separator 'Output:'
  opts.separator '────'
  opts.on('-o', '--output FILE', 'Output file (default: inferred from title)') do |o|
    options[:output] = o
  end
  opts.on('--json', 'JSON output') { options[:json] = true }
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
  opts.separator "  #{exe} download --url 'https://youtube.com/watch?v=xyz' --format mp4 --verbose"
  opts.separator "  #{exe} download -u https://youtube.com/watch?v=abc -f mp3 -q best -o song.mp3"
  opts.separator "  #{exe} info -u 'https://youtube.com/watch?v=xyz' --json"
  opts.separator "  #{exe} list-formats -u 'https://youtube.com/watch?v=xyz'"
  opts.separator "  #{exe} download --dry-run --verbose"
  opts.separator "  #{exe} --version"
end

# ── Command dispatch ────────────────────────────────────────────────────────

def extract_command(argv)
  command = argv.shift

  unless command && %w[download info list-formats].include?(command)
    warn 'Error: Expected one of: download, info, list-formats'
    warn "Try '#{File.basename($PROGRAM_NAME)} --help'."
    exit 1
  end

  command
end

def validate_command(command, options)
  return if command != 'download' || options[:url]

  warn 'Error: --url is required for download'
  exit 1
end

# ── Command handlers ────────────────────────────────────────────────────────

def run_download(options)
  {
    command: 'download',
    action: 'downloading',
    url: options[:url],
    format: options[:format],
    quality: options[:quality],
    output: options[:output] || infer_filename(options[:url], options[:format]),
    concurrent: options[:concurrent_downloads],
    dry_run: options[:dry_run],
    timestamp: Time.now.iso8601
  }
end

def run_info(options)
  {
    command: 'info',
    action: 'fetching video info',
    url: options[:url],
    title: 'Sample Video Title',
    duration: '3:45',
    views: 123_456,
    author: 'Sample Channel',
    timestamp: Time.now.iso8601
  }
end

def run_list_formats(options)
  formats = %w[mp3 mp4 mkv webm].map { |f| { format: f, quality: 'best', size: '25MB' } }
  {
    command: 'list-formats',
    action: 'listing available formats',
    url: options[:url],
    formats: formats,
    timestamp: Time.now.iso8601
  }
end

# ── Output formatting ───────────────────────────────────────────────────────

def format_result(result, options)
  if options[:json]
    puts JSON.pretty_generate(result)
  else
    format_text(result, options)
  end
end

def format_text(result, options)
  puts "[VERBOSE] Starting #{result[:command]}..." if options[:verbose]

  case result[:command]
  when 'download'
    puts "Downloading: #{result[:url]}"
    puts "Format:      #{result[:format]}"
    puts "Quality:     #{result[:quality]}"
    puts "Output:      #{result[:output]}"
    puts '[DRY RUN — no files written]' if result[:dry_run]
  when 'info'
    puts "Title:   #{result[:title]}"
    puts "Author:  #{result[:author]}"
    puts "Duration: #{result[:duration]}"
    puts "Views:   #{result[:views]}"
  when 'list-formats'
    puts "Available formats:"
    result[:formats].each { |f| puts "  #{f[:format]} - #{f[:quality]} - #{f[:size]}" }
  end
end

def infer_filename(url, format)
  # Simple extraction from YouTube URL for demo purposes
  match = url.match(/v=([a-zA-Z0-9_-]+)/)
  id = match&.captures&.first || 'video'
  "#{id}.#{format}"
end

# ── Main ────────────────────────────────────────────────────────────────────

def main(argv = ARGV)
  options = parse_options(argv)
  command = extract_command(argv)
  validate_command(command, options)

  result = case command
           when 'download' then run_download(options)
           when 'info' then run_info(options)
           when 'list-formats' then run_list_formats(options)
           end

  format_result(result, options)
end

main if $PROGRAM_NAME == __FILE__
