#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Raw SQL strings are error-prone and tedious for complex queries.
# Example: A server inventory with inserts, filtered queries, and table creation.
#
# Solution: Sequel — a Ruby ORM that generates SQL from method calls.
# Visibility: `gem install sequel`. Optional but more Ruby-idiomatic than raw SQL.

require 'sequel'

# Connect to SQLite — Sequel auto-detects the adapter from the URI scheme
DB = Sequel.sqlite('/tmp/sequel_demo.db')

# CREATE TABLE — Ruby DSL instead of SQL string
DB.create_table?(:servers) do
  primary_key :id
  String :hostname, null: false, unique: true
  String :ip
  String :os, default: 'unknown'
  String :status, default: 'unknown'
end
puts "Table created with Sequel DSL."

# INSERT — hash-based, like regular Ruby objects
DB[:servers].insert(hostname: 'web-01', ip: '10.0.1.10', os: 'Ubuntu 22.04', status: 'online')
DB[:servers].insert(hostname: 'db-01', ip: '10.0.1.20', os: 'Debian 12', status: 'online')
DB[:servers].insert(hostname: 'web-02', ip: '10.0.1.11', os: 'Ubuntu 22.04', status: 'offline')
puts "Inserted 3 servers."

# SELECT — method chaining, no raw SQL strings
online = DB[:servers].where(status: 'online').all
puts "\n=== Online servers (Sequel) ==="
online.each { |s| puts "  #{s[:hostname]} (#{s[:ip]})" }

# Aggregation
puts "\nTotal: #{DB[:servers].count} servers"

# UPDATE — hash conditions
DB[:servers].where(hostname: 'web-02').update(status: 'online')
puts "web-02 back online."

# DELETE
DB[:servers].where(hostname: 'db-01').delete
puts "Removed db-01."

File.delete('/tmp/sequel_demo.db') if File.exist?('/tmp/sequel_demo.db')

# This could also be done like this:
# Raw SQL with sqlite3 gem — more explicit but more verbose:
#
#   db = SQLite3::Database.new('inventory.db')
#   db.execute("CREATE TABLE ...")
#   db.execute("INSERT INTO servers (hostname) VALUES (?)", ['web-01'])
#   db.execute("SELECT * FROM servers WHERE status = 'online'")
#
# Sequel is optional. For scripting, raw SQL is fine. For complex apps,
# Sequel reduces boilerplate and prevents SQL syntax errors.
#
# Thinking in Ruby
#
# Sequel demonstrates a distinctly Ruby approach to database interaction: instead
# of writing SQL strings, you build queries through method chaining — turning
# `SELECT * FROM servers WHERE status = 'online'` into `DB[:servers].where(status: 'online').all`.
# This isn't about hiding SQL; it's about making Ruby code read more naturally
# while still generating efficient SQL. Sequel's DSL is pure Ruby (not a separate
# query language), so your editor, linter, and type checker all understand it.
