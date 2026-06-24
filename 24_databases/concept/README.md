# Databases & SQL — Practice Suite

Store, query, and analyze sysadmin data with SQLite — the embedded database
that needs no server, no config, and no setup. Covers raw SQL, CRUD operations,
schema migrations, and the Sequel ORM.

> **Prerequisites:** Groups 02 (regex), 05 (filesystem), 13 (data parsing), 15 (processes).
> Requires: `gem install sqlite3` (and optionally `gem install sequel`).

## Quick Start

```bash
# Setup & CRUD
ruby 01_sqlite_setup.rb              # Open a database, create a table, insert/query
ruby 02_sqlite_crud.rb               # Full CRUD on a server inventory table

# Querying
ruby 03_sqlite_query.rb              # WHERE, ORDER BY, GROUP BY, JOINs

# Schema management
ruby 04_sqlite_schema.rb             # ALTER TABLE, indexes, PRAGMA, transactions

# Sequel ORM
ruby 05_sqlite_sequel.rb             # Same operations with Sequel's Ruby DSL
```

## Learning Path

### SQLite Basics (~30 min)

| Script | Concept |
|---|---|
| `01_sqlite_setup.rb` | `SQLite3::Database.new`, `execute`, `get_first_row`, placeholders |
| `02_sqlite_crud.rb` | INSERT, SELECT, UPDATE, DELETE with `?` params |
| `03_sqlite_query.rb` | WHERE, ORDER BY, LIMIT, COUNT, GROUP BY, JOIN |

### Schema & Tooling (~20 min)

| Script | Concept |
|---|---|
| `04_sqlite_schema.rb` | ALTER TABLE, CREATE INDEX, PRAGMA, transaction blocks |
| `05_sqlite_sequel.rb` | Sequel ORM — `create_table?`, `DB[:table]`, method chaining |

## Common Patterns

```ruby
require 'sqlite3'

# Open database (creates if missing)
db = SQLite3::Database.new('data.db')
db.results_as_hash = true

# Create table
db.execute("CREATE TABLE IF NOT EXISTS items (id INTEGER PRIMARY KEY, name TEXT)")

# Insert with placeholders (ALWAYS use ? — never string interpolation)
db.execute("INSERT INTO items (name) VALUES (?)", ['something'])

# Query — returns array of hashes
items = db.execute("SELECT * FROM items WHERE name LIKE ?", ['%thing%'])

# Single row
row = db.get_first_row("SELECT * FROM items WHERE id = ?", [1])

# Transaction
db.transaction do |txn|
  txn.execute("INSERT INTO items (name) VALUES (?)", ['a'])
  txn.execute("INSERT INTO items (name) VALUES (?)", ['b'])
end
```

## Now Build Your Own

Build a **service monitoring tool** that:
1. Stores a list of services (name, expected status, check interval)
2. Queries the OS for running services every N seconds (via `Open3`)
3. Logs status changes (service down, service recovered) to a log table
4. Reports: "Which services have been down more than 3 times today?"
