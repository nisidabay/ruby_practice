#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — SQLite real-world practice
# Three independent exercises covering package tracking, log querying, and config backups.

require 'sqlite3'

# === Exercise 1: Package Inventory Tracker ===
puts "=== Exercise 1: Package Inventory Tracker ==="
db1 = SQLite3::Database.new('/tmp/packages.db')
db1.results_as_hash = true
db1.execute("CREATE TABLE IF NOT EXISTS packages (id INTEGER PRIMARY KEY, name TEXT UNIQUE, version TEXT, installed_at TEXT)")
db1.execute("INSERT OR IGNORE INTO packages (name, version) VALUES (?, ?)", ['curl', '7.88.1'])
db1.execute("INSERT OR IGNORE INTO packages (name, version) VALUES (?, ?)", ['nginx', '1.24.0'])
db1.execute("INSERT OR IGNORE INTO packages (name, version) VALUES (?, ?)", ['postgresql', '15.4'])
puts "Installed packages:"
db1.execute("SELECT * FROM packages ORDER BY name") do |row|
  puts "  #{row['name']} v#{row['version']} (installed: #{row['installed_at']})"
end
File.delete('/tmp/packages.db') if File.exist?('/tmp/packages.db')

# === Exercise 2: Log Query Tool ===
puts "\n=== Exercise 2: Log Query Tool ==="
db2 = SQLite3::Database.new('/tmp/syslog.db')
db2.results_as_hash = true
db2.execute("CREATE TABLE IF NOT EXISTS syslog (id INTEGER PRIMARY KEY, timestamp TEXT, severity TEXT, message TEXT)")
db2.execute("INSERT INTO syslog (timestamp, severity, message) VALUES (?, ?, ?)",
            ['2026-06-24 10:00:00', 'error', 'Disk I/O error on sda1'])
db2.execute("INSERT INTO syslog (timestamp, severity, message) VALUES (?, ?, ?)",
            ['2026-06-24 11:00:00', 'info', 'Service nginx started'])
db2.execute("INSERT INTO syslog (timestamp, severity, message) VALUES (?, ?, ?)",
            ['2026-06-24 12:00:00', 'warn', 'CPU temperature 85C'])
puts "Errors since 2026-06-01:"
db2.execute("SELECT * FROM syslog WHERE severity = ? AND timestamp >= ?",
            ['error', '2026-06-01']) do |row|
  puts "  [#{row['timestamp']}] #{row['message']}"
end
File.delete('/tmp/syslog.db') if File.exist?('/tmp/syslog.db')

# === Exercise 3: Configuration Backup Tracker ===
puts "\n=== Exercise 3: Configuration Backup Tracker ==="
db3 = SQLite3::Database.new('/tmp/config_backups.db')
db3.results_as_hash = true
db3.execute("CREATE TABLE IF NOT EXISTS backup_files (id INTEGER PRIMARY KEY, path TEXT, checksum TEXT, backed_up_at TEXT)")
db3.execute("INSERT INTO backup_files (path, checksum) VALUES (?, ?)",
            ['/etc/nginx/nginx.conf', 'a1b2c3d4'])
db3.execute("INSERT INTO backup_files (path, checksum) VALUES (?, ?)",
            ['/etc/ssh/sshd_config', 'e5f6g7h8'])
db3.execute("INSERT INTO backup_files (path, checksum) VALUES (?, ?)",
            ['/etc/hosts', 'i9j0k1l2'])
puts "Backed up configuration files:"
db3.execute("SELECT * FROM backup_files") do |row|
  puts "  #{row['path']} — checksum: #{row['checksum']} (backed up: #{row['backed_up_at']})"
end
File.delete('/tmp/config_backups.db') if File.exist?('/tmp/config_backups.db')
