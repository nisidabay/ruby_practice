# log_db — Log File Importer & Query Tool

Import syslog-style log files into SQLite and query them by date, severity,
and statistics — all from the command line.

## Why

Parsing log files with `grep`/`awk` works for one-off searches, but when you
need to ask multiple questions (How many errors today? Which server logged
the most warnings? Show me all fatals from last week.) a database is faster
and more flexible.

## Installation

```bash
gem install sqlite3
```

## Usage

### Import a log file

Parses `/var/log/syslog` (or any syslog-formatted file), infers severity
from message keywords, and stores each entry in SQLite.

```bash
ruby log_db.rb import /var/log/syslog
# => Imported 1243 log entries from /var/log/syslog
# => Database: /tmp/log_db.sqlite
```

### Query entries

Filter by date range and/or severity level.

```bash
# All errors
ruby log_db.rb query --severity error

# Errors since a date
ruby log_db.rb query --since "2026-06-01" --severity error

# Last 10 entries of any severity
ruby log_db.rb query --limit 10
```

### Show statistics

Count entries per severity level and per day.

```bash
ruby log_db.rb stats
# => === Log Stats ===
# => Total entries: 1243
# =>
# => Per severity:
# =>   info: 845
# =>   warn: 267
# =>   error: 112
# =>   fatal: 12
# =>   debug: 7
# =>
# => Per day:
# =>   2026-06-24: 523 entries
# =>   2026-06-23: 441 entries
```

## Log Format Support

Parses standard syslog format:

```
Jun 24 10:00:00 web-01 nginx[1234]: connect failed: Connection refused
```

Severity is inferred from message keywords:
- **fatal** — `fatal`, `panic`, `emergency`
- **error** — `error`, `failed`, `unable`, `exception`
- **warn** — `warn`, `caution`, `alert`
- **info** — `info`, `notice`, `started`, `stopped`
- **debug** — everything else

## Database Schema

```sql
CREATE TABLE log_entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  timestamp TEXT NOT NULL,
  severity TEXT,
  hostname TEXT,
  process TEXT,
  message TEXT,
  raw_line TEXT
);
```

Indexes on `timestamp` and `severity` speed up the common query patterns.
