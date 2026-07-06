#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to manage records — create, read, update, delete — for sysadmin data.
# Example: A server inventory where each server has hostname, IP, OS, and status.
#
# Solution: SQLite3 CRUD with parameterized queries (? placeholders).
# Visibility: Always use ? placeholders — never interpolate values into SQL.

require 'sqlite3'

db = SQLite3::Database.new('/tmp/inventory.db')
db.results_as_hash = true

db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS servers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    hostname TEXT NOT NULL,
    ip TEXT NOT NULL,
    os TEXT,
    status TEXT DEFAULT 'unknown'
  )
SQL

# INSERT — ? placeholders prevent SQL injection
db.execute("INSERT INTO servers (hostname, ip, os, status) VALUES (?, ?, ?, ?)",
           ['web-01', '10.0.1.10', 'Ubuntu 22.04', 'online'])
db.execute("INSERT INTO servers (hostname, ip, os, status) VALUES (?, ?, ?, ?)",
           ['db-01', '10.0.1.20', 'Debian 12', 'online'])
db.execute("INSERT INTO servers (hostname, ip, os, status) VALUES (?, ?, ?, ?)",
           ['web-02', '10.0.1.11', 'Ubuntu 22.04', 'offline'])

# SELECT — returns array of hashes (with results_as_hash = true)
servers = db.execute("SELECT * FROM servers")
puts "=== All servers (#{servers.size} rows) ==="
servers.each { |s| puts "  #{s['hostname']} (#{s['ip']}) — #{s['os']}: #{s['status']}" }

# get_first_row — single row, nil if none
offline = db.get_first_row("SELECT * FROM servers WHERE status = ?", ['offline'])
puts "\nFirst offline server: #{offline['hostname']}" if offline

# UPDATE
db.execute("UPDATE servers SET status = ? WHERE hostname = ?", ['online', 'web-02'])
puts "Updated web-02 to online."

# DELETE
db.execute("DELETE FROM servers WHERE hostname = ?", ['db-01'])
puts "Removed db-01."

# Verify final state
puts "\n=== Final inventory ==="
db.execute("SELECT * FROM servers") do |row|
  puts "  #{row['hostname']} — #{row['status']}"
end

File.delete('/tmp/inventory.db') if File.exist?('/tmp/inventory.db')

# This could also be done like this:
# YAML files — but no querying, no concurrent writes, no rollback:
#
#   require 'yaml'
#   servers = YAML.load_file('inventory.yml') rescue []
#   servers << { hostname: 'web-01', ip: '10.0.1.10' }
#   File.write('inventory.yml', YAML.dump(servers))
#
# SQLite gives you SQL filtering, ACID transactions, and no file corruption.
#
# Thinking in Ruby
#
# The CRUD pattern in Ruby with SQLite is refreshingly direct: parameterized
# queries (`?` placeholders) prevent SQL injection, `results_as_hash` gives
# readable column access, and `get_first_row` provides convenient single-row
# fetching. Ruby doesn't abstract away SQL — it makes SQL usage safe and
# ergonomic. The emphasis on parameterized queries over string interpolation
# is a security best practice that Ruby's API design makes easy to follow.
