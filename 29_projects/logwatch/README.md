# logwatch - Log Viewer with Filtering

Tail and filter log files with syntax highlighting.

## Usage

```bash
logwatch [file] [options]
```

### Options

| Option | Description |
|--------|-------------|
| `-f, --follow` | Follow file (like `tail -f`) |
| `-l, --lines N` | Number of lines to show (default: 100) |
| `-F, --filter REGEX` | Filter lines matching regex |
| `-H, --highlight` | Highlight matched patterns |
| `--no-color` | Disable colors |
| `-t, --time` | Show timestamps |
| `-r, --relative` | Show relative time |
| `-s, --since TIME` | Show entries since time |
| `--json` | Parse as JSON lines |
| `--combined` | Parse nginx/apache combined format |
| `-h, --help` | Show help |

## Examples

### Basic Usage

```bash
# View log file
logwatch /var/log/syslog

# Follow log (live updates)
logwatch --follow /var/log/syslog

# Show last 50 lines
logwatch -l 50 /var/log/syslog
```

### Filtering

```bash
# Filter by regex
logwatch --filter "error|warning" /var/log/syslog

# Highlight matches
logwatch --filter "error" --highlight /var/log/syslog

# Case-insensitive filter
logwatch --filter "(?i)error" app.log
```

### Time-based Filtering

```bash
# Show entries from last hour
logwatch --since "1 hour ago" /var/log/syslog

# Show entries from today
logwatch --since today app.log

# Show entries from specific time
logwatch --since "2026-04-12 10:00" app.log
```

### Reading from stdin

```bash
# Pipe command output
journalctl -u nginx | logwatch --filter "error"

# Watch a process
my-app 2>&1 | logwatch --follow
```

## Timestamp Detection

Automatically detects common timestamp formats:

| Format | Example |
|--------|---------|
| ISO 8601 | `2026-04-12T10:30:00` |
| Syslog | `Apr 12 10:30:00` |
| Time only | `10:30:00` |
| Bracketed | `[2026-04-12 10:30:00]` |

## Relative Time

With `--relative`:

```
10:30:00 Entry 1 minute ago
10:29:00 Entry 2 minutes ago
10:25:00 Entry 6 minutes ago
```

## Color Coding

Automatic highlighting by log level:

| Level | Color |
|-------|-------|
| ERROR | Red |
| WARN | Yellow |
| INFO | Green |
| DEBUG | Blue |
| FATAL | Magenta |

## JSON Log Parsing

```bash
# Parse JSON lines format
logwatch --json app.log

# Filter JSON field
logwatch --json --filter '"level":"error"' app.log
```

## Nginx/Apache Combined Format

```bash
# Parse combined log format
logwatch --combined /var/log/nginx/access.log

# Filter HTTP errors
logwatch --combined --filter " 5[0-9][0-9] " /var/log/nginx/access.log
```

## Installation

```bash
cp logwatch ~/.local/bin/
chmod +x ~/.local/bin/logwatch
```

## Common Use Cases

```bash
# Watch nginx errors
logwatch -f -F "error" /var/log/nginx/error.log

# Monitor application logs
tail -f /var/log/myapp/*.log | logwatch --filter "error|exception"

# Find slow requests (>1s)
logwatch --combined --filter " [0-9]{4,}\ms" access.log

# Daily log summary
logwatch --since today --filter "error|warn" /var/log/syslog
```