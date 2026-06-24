#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Raw data isn't useful without filtering, grouping, and joining.
# Example: Find log entries by severity, count errors per day, join logs to servers.
#
# Solution: WHERE, ORDER BY, LIMIT, aggregation (COUNT, SUM), and JOINs.
# Visibility: These make up 90% of what sysadmin SQL queries need.

require 'sqlite3'

db = SQLite3::Database.new('/tmp/logs.db')
db.results_as_hash = true

# Create sample tables with foreign key relationship
db.execute_batch <<-SQL
  CREATE TABLE IF NOT EXISTS servers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hostname TEXT UNIQUE
  );
  CREATE TABLE IF NOT EXISTS logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    server_id INTEGER REFERENCES servers(id),
    severity TEXT CHECK(severity IN ('info', 'warn', 'error', 'fatal')),
    message TEXT,
    logged_at TEXT DEFAULT (datetime('now'))
  );
  INSERT OR IGNORE INTO servers (hostname) VALUES ('web-01'), ('db-01'), ('web-02');
SQL

# Insert sample log entries
db.execute("INSERT INTO logs (server_id, severity, message) VALUES (?, ?, ?)",
           [1, 'error', 'Out of memory'])
db.execute("INSERT INTO logs (server_id, severity, message) VALUES (?, ?, ?)",
           [1, 'info', 'Request served in 42ms'])
db.execute("INSERT INTO logs (server_id, severity, message) VALUES (?, ?, ?)",
           [2, 'fatal', 'Disk full — shutting down'])
db.execute("INSERT INTO logs (server_id, severity, message) VALUES (?, ?, ?)",
           [3, 'warn', 'CPU at 95%'])
db.execute("INSERT INTO logs (server_id, severity, message) VALUES (?, ?, ?)",
           [1, 'error', 'Connection timeout to db-01'])

# WHERE + ORDER BY + LIMIT — filter, sort, cap results
puts "=== Last 3 error/fatal entries ==="
db.execute("SELECT * FROM logs WHERE severity IN ('error', 'fatal') ORDER BY logged_at DESC LIMIT 3") do |row|
  puts "  [#{row['severity'].upcase}] #{row['message']} (#{row['logged_at']})"
end

# COUNT + GROUP BY — aggregate by category
puts "\n=== Severity counts ==="
db.execute("SELECT severity, COUNT(*) AS cnt FROM logs GROUP BY severity ORDER BY cnt DESC") do |row|
  puts "  #{row['severity']}: #{row['cnt']}"
end

# JOIN — combine related tables
puts "\n=== Error logs with server names ==="
db.execute(<<-SQL, ['error']) do |row|
  SELECT l.severity, l.message, s.hostname, l.logged_at
  FROM logs l JOIN servers s ON l.server_id = s.id
  WHERE l.severity = ?
  ORDER BY l.logged_at
SQL
  puts "  #{row['hostname']}: [#{row['severity'].upcase}] #{row['message']}"
end

# SUM/COUNT with JOIN
puts "\n=== Warning count per server ==="
db.execute(<<-SQL) do |row|
  SELECT s.hostname, COUNT(*) AS warn_count
  FROM logs l JOIN servers s ON l.server_id = s.id
  WHERE l.severity = 'warn'
  GROUP BY s.hostname
SQL
  puts "  #{row['hostname']}: #{row['warn_count']} warnings"
end

File.delete('/tmp/logs.db') if File.exist?('/tmp/logs.db')

# This could also be done like this:
# grep/awk on raw logs — works but no relational joins or aggregation:
#
#   grep 'error' /var/log/app.log | wc -l
#   awk '{print $1}' /var/log/app.log | sort | uniq -c
#
# SQLite lets you ask questions across related tables — joins,
# groups, filters — in a single query.
