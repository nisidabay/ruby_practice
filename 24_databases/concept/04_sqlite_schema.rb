#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Databases evolve — you need to add columns, create indexes, inspect structure.
# Example: Add a 'last_seen' column to a servers table without losing data.
#
# Solution: ALTER TABLE, CREATE INDEX, PRAGMA introspection, and transactions.
# Visibility: Always wrap schema migrations in transactions for safety.

require 'sqlite3'

db = SQLite3::Database.new('/tmp/schema.db')
db.results_as_hash = true

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS servers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hostname TEXT NOT NULL UNIQUE,
    ip TEXT
  )
SQL

# PRAGMA — inspect table structure (column names, types, constraints)
puts "=== Table info (columns) ==="
db.execute("PRAGMA table_info(servers)") do |col|
  nn = col['notnull'] == 1 ? 'NOT NULL' : ''
  pk = col['pk'] == 1 ? 'PK' : ''
  puts "  #{col['name']} (#{col['type']}) #{nn} #{pk}".strip
end

# ALTER TABLE — add a column to existing table
db.execute("ALTER TABLE servers ADD COLUMN last_seen TEXT")
puts "\nAdded column 'last_seen'."

# CREATE INDEX — speed up lookups on frequently queried columns
db.execute("CREATE INDEX IF NOT EXISTS idx_servers_hostname ON servers(hostname)")
puts "Created index on hostname."

# Transaction — wrap multi-step migrations atomically
puts "\n=== Transactional migration ==="
db.transaction do |txn|
  txn.execute("ALTER TABLE servers ADD COLUMN os TEXT DEFAULT 'unknown'")
  # If anything fails in this block, the entire transaction rolls back
  puts "Migration committed atomically."
end

# PRAGMA — schema version (useful for tracking migrations)
version = db.get_first_value("PRAGMA schema_version")
puts "\nSchema version: #{version}"

# Final structure
puts "\n=== Final table info ==="
db.execute("PRAGMA table_info(servers)") do |col|
  puts "  #{col['name']} (#{col['type']})"
end

File.delete('/tmp/schema.db') if File.exist?('/tmp/schema.db')

# This could also be done like this:
# Raw file surgery — NEVER do this:
#
#   File.open('data.db', 'ab') { |f| ... }  # WILL corrupt the database
#
# ALTER TABLE is safe. SQLite transactions ensure migrations either
# complete fully or roll back cleanly — no partial schema changes.
