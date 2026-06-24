#!/usr/bin/env ruby
# frozen_string_literal: true

# concept/exercises.rb — SQLite basics practice
# All exercises use the backup tracking domain.

require 'sqlite3'

puts '=== Exercise 1: Create a database and table for system backups ==='
db = SQLite3::Database.new('/tmp/backups.db')
db.results_as_hash = true
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS backups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    path TEXT NOT NULL,
    size_bytes INTEGER,
    backup_date TEXT DEFAULT (datetime('now')),
    status TEXT DEFAULT 'pending'
  )
SQL
puts 'Backup table created.'

puts "\n=== Exercise 2: Insert 3 backup records ==="
db.execute("INSERT INTO backups (path, size_bytes, status) VALUES (?, ?, ?)",
           ['/etc', 2_456_000, 'completed'])
db.execute("INSERT INTO backups (path, size_bytes, status) VALUES (?, ?, ?)",
           ['/var/log', 1_789_500_000, 'completed'])
db.execute("INSERT INTO backups (path, size_bytes, status) VALUES (?, ?, ?)",
           ['/home', 523_000_000, 'pending'])
puts 'Inserted 3 backup records.'

puts "\n=== Exercise 3: Query backups larger than 1GB ==="
big = db.execute("SELECT * FROM backups WHERE size_bytes > 1000000000")
big.each { |b| puts "  #{b['path']}: #{b['size_bytes']} bytes (#{b['status']})" }

puts "\n=== Exercise 4: Update backup status ==="
db.execute("UPDATE backups SET status = ? WHERE path = ?", ['completed', '/home'])
puts '/home backup marked completed.'

puts "\n=== Exercise 5: Join backup records with server table ==="
db.execute("CREATE TABLE IF NOT EXISTS servers (id INTEGER PRIMARY KEY, hostname TEXT)")
db.execute("INSERT OR IGNORE INTO servers (id, hostname) VALUES (1, 'web-01')")
# Add server_id column and link backups to servers
db.execute("ALTER TABLE backups ADD COLUMN server_id INTEGER")
db.execute("UPDATE backups SET server_id = 1 WHERE path = '/etc'")
rows = db.execute(<<-SQL)
  SELECT b.path, b.size_bytes, s.hostname
  FROM backups b JOIN servers s ON b.server_id = s.id
SQL
rows.each { |r| puts "  #{r['hostname']}: #{r['path']} (#{r['size_bytes']} bytes)" }

# Clean up
File.delete('/tmp/backups.db') if File.exist?('/tmp/backups.db')
