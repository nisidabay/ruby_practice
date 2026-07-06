#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need a lightweight database for sysadmin scripts — no server, no config.
# Example: Track installed packages, server inventory, or backup records without CSV pain.
#
# Solution: SQLite3 gem — embedded SQL database, zero configuration, file-based.
# Visibility: `gem install sqlite3`. Single-user, perfect for CLI scripts.

require 'sqlite3'

# Open (or create) a database — file appears on first write
db = SQLite3::Database.new('/tmp/sysadmin.db')
puts "Database opened: #{db.filename}"

# Execute raw SQL directly — CREATE TABLE IF NOT EXISTS is safe to re-run
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS packages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    version TEXT,
    installed_at TEXT DEFAULT (datetime('now'))
  )
SQL
puts "Table 'packages' ready."

# Enable results as hashes (instead of default integer arrays)
db.results_as_hash = true

# Insert via parameterized query (? placeholders)
db.execute("INSERT OR IGNORE INTO packages (name, version) VALUES (?, ?)",
           ['nginx', '1.24.0'])

# Query back — get_first_row returns one row (or nil)
row = db.get_first_row("SELECT * FROM packages WHERE name = ?", ['nginx'])
puts "Package: #{row['name']} v#{row['version']}, installed: #{row['installed_at']}"

# Clean up
File.delete('/tmp/sysadmin.db') if File.exist?('/tmp/sysadmin.db')

# This could also be done like this:
# CSV files — but no querying, no type safety, no concurrent access:
#
#   require 'csv'
#   CSV.open('packages.csv', 'a') { |csv| csv << ['nginx', '1.24.0', Time.now.iso8601] }
#
# SQLite gives you SQL queries, constraints, and ACID transactions — all
# without a database server process.
#
# Thinking in Ruby
#
# SQLite's integration into Ruby scripting reflects a pragmatic toolmaking
# philosophy: when you need persistent structured data, reach for an embedded
# SQL database, not CSV files. The sqlite3 gem gives Ruby scripts ACID
# transactions, SQL queries, and concurrent access without the operational
# overhead of a database server. This is especially valuable in sysadmin
# scripts where deploying PostgreSQL or MySQL would be overkill — SQLite IS
# the database server, embedded in your Ruby process.
