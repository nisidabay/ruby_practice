#!/usr/bin/env ruby
# frozen_string_literal: true

# log_db.rb — Import, query, and analyze syslog files in SQLite
#
# Usage:
#   ruby log_db.rb import /var/log/syslog
#   ruby log_db.rb query --since "2026-06-01" --severity error
#   ruby log_db.rb stats
#   ruby log_db.rb --help

require 'sqlite3'
require 'optparse'
require 'time'

DB_PATH = '/tmp/log_db.sqlite'

# Regex for standard syslog format:
#   Jun 24 10:00:00 hostname process[pid]: message
LOG_PATTERN = /
  ^
  (?<month>\w{3})\s+
  (?<day>\d{1,2})\s+
  (?<time>\d{2}:\d{2}:\d{2})\s+
  (?<hostname>\S+)\s+
  (?<process>\S+?)(?:\[\d+\])?:\s+
  (?<message>.+)
$/x

MONTH_ABBR = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec].freeze

def setup_database
  db = SQLite3::Database.new(DB_PATH)
  db.results_as_hash = true
  db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS log_entries (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      timestamp TEXT NOT NULL,
      severity TEXT,
      hostname TEXT,
      process TEXT,
      message TEXT,
      raw_line TEXT
    )
  SQL
  db.execute("CREATE INDEX IF NOT EXISTS idx_timestamp ON log_entries(timestamp)")
  db.execute("CREATE INDEX IF NOT EXISTS idx_severity ON log_entries(severity)")
  db
end

def infer_severity(message)
  case message
  when /fatal|panic|emergency/i then 'fatal'
  when /error|failed|unable|exception|refused/i then 'error'
  when /warn|caution|alert/i then 'warn'
  when /info|notice|started?|stopped?|connected/i then 'info'
  else 'debug'
  end
end

def parse_syslog_timestamp(month, day, time_str)
  month_num = MONTH_ABBR.index(month.capitalize)&.+(1) || 1
  year = Time.now.year
  # Handle Dec → Jan rollover
  year -= 1 if month_num > Time.now.month + 1
  "#{year}-#{format('%02d', month_num)}-#{format('%02d', day)} #{time_str}"
end

def import_log(file_path)
  unless File.exist?(file_path)
    warn "Error: file not found: #{file_path}"
    exit 1
  end

  db = setup_database
  count = 0

  File.foreach(file_path) do |line|
    match = LOG_PATTERN.match(line)
    next unless match

    timestamp = parse_syslog_timestamp(match[:month], match[:day].to_i, match[:time])
    severity = infer_severity(match[:message])

    db.execute(
      "INSERT INTO log_entries (timestamp, severity, hostname, process, message, raw_line) VALUES (?, ?, ?, ?, ?, ?)",
      [timestamp, severity, match[:hostname], match[:process], match[:message], line.chomp]
    )
    count += 1
  end

  puts "Imported #{count} log entries from #{file_path}"
  puts "Database: #{DB_PATH}"
end

def query_logs(since: nil, severity: nil, limit: 50)
  db = setup_database
  conditions = []
  params = []

  conditions << "timestamp >= ?" and params << since if since
  conditions << "severity = ?"   and params << severity if severity

  where_clause = conditions.empty? ? '' : "WHERE #{conditions.join(' AND ')}"
  sql = "SELECT * FROM log_entries #{where_clause} ORDER BY timestamp DESC LIMIT ?"
  params << limit

  results = db.execute(sql, params)
  if results.empty?
    puts 'No matching log entries found.'
  else
    puts "Found #{results.length} entries:"
    results.each do |row|
      puts "[#{row['timestamp']}] [#{row['severity'].upcase}] #{row['hostname']} #{row['process']}: #{row['message']}"
    end
  end
end

def show_stats
  db = setup_database
  total = db.get_first_value("SELECT COUNT(*) FROM log_entries")
  return puts('No entries in database. Import a log file first.') if total == 0

  puts '=== Log Stats ==='
  puts "Total entries: #{total}"

  puts "\nPer severity:"
  db.execute("SELECT severity, COUNT(*) AS cnt FROM log_entries GROUP BY severity ORDER BY cnt DESC") do |row|
    puts "  #{row['severity']}: #{row['cnt']}"
  end

  puts "\nPer day (last 10):"
  db.execute("SELECT DATE(timestamp) AS day, COUNT(*) AS cnt FROM log_entries GROUP BY day ORDER BY day DESC LIMIT 10") do |row|
    puts "  #{row['day']}: #{row['cnt']} entries"
  end
end

# --- CLI ---

options = {}
parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ruby log_db.rb <command> [options]'

  opts.separator "\nCommands:"
  opts.separator "  import <file>    Parse and import log file into SQLite"
  opts.separator "  query            Query imported log entries"
  opts.separator "  stats            Show severity and daily counts"

  opts.separator "\nQuery options:"
  opts.on('--since DATE', 'Filter entries after this date (e.g. 2026-06-01)') do |d|
    options[:since] = d
  end
  opts.on('-s', '--severity LEVEL', 'Filter by severity (debug, info, warn, error, fatal)') do |s|
    options[:severity] = s.downcase
  end
  opts.on('-n', '--limit N', Integer, 'Max results (default: 50)') do |n|
    options[:limit] = n
  end

  opts.separator "\nGeneral options:"
  opts.on('-h', '--help', 'Show this message') do
    puts opts
    exit
  end
end

parser.parse!

command = ARGV.shift

case command
when 'import'
  file = ARGV.shift
  unless file
    warn "Error: specify a log file to import.\nUsage: ruby log_db.rb import <file>"
    exit 1
  end
  import_log(file)
when 'query'
  query_logs(since: options[:since], severity: options[:severity], limit: options[:limit] || 50)
when 'stats'
  show_stats
else
  warn "Error: unknown command '#{command}'. Use --help for usage."
  exit 1
end
