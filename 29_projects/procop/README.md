# procop - Process Monitor

Process monitor and killer with fuzzy search.

## Usage

```bash
procop [command] [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `list` | List all processes (default) |
| `find <name>` | Find processes by name |
| `kill` | Interactive kill (fzf-style) |
| `top` | Top-like view |
| `tree` | Process tree view |

### Options

| Option | Description |
|--------|-------------|
| `-u, --user USER` | Filter by user |
| `-s, --sort FIELD` | Sort by: cpu, mem, pid, name |
| `-f, --filter NAME` | Filter by process name |
| `-i, --interactive` | Interactive mode |
| `-S, --signal SIG` | Signal to send (TERM, KILL, etc) |
| `-j, --json` | JSON output |
| `-a, --all` | Show all users |
| `-h, --help` | Show help |

## Examples

```bash
# List all processes
procop

# Find specific process
procop find chrome

# List processes by user
procop --user nisidabay

# Sort by CPU usage
procop --sort cpu

# Sort by memory
procop --sort mem

# Interactive kill
procop kill

# Interactive mode with navigation
procop --interactive

# JSON output for scripting
procop --json | jq '.[] | select(.cpu > 50)'

# Find and kill by name
procop find firefox | head -1 | xargs -I{} procop kill {}
```

## Interactive Mode

When running `procop --interactive`:

| Key | Action |
|-----|--------|
| `j/k` | Navigate down/up |
| `Enter` | Kill selected process |
| `/` | Enter filter/search |
| `r` | Refresh |
| `q` | Quit |

## Output Format

```
PID     PPID    USER   STATUS   CPU%    MEM     NAME
1234    1       user   running  12.5%   150M    firefox
5678    1234    user   sleeping 0.3%    50M     chrome
```

Color-coded by CPU usage:
- **Red (>50%)**: High CPU
- **Yellow (>20%)**: Moderate CPU
- **Default**: Normal

## Kill Specific Process

```bash
# Kill by PID
procop kill 12345

# Kill with specific signal
procop kill --signal KILL 12345
procop kill -S TERM 12345
```

## Dependencies

- Ruby 3.0+
- `sys-proctable` gem (optional, falls back to `/proc`)

## Installation

```bash
cp procop ~/.local/bin/
chmod +x ~/.local/bin/procop
```

## Linux /proc Backend

If `sys-proctable` is not available, uses `/proc`:

```bash
# Reads from /proc/[pid]/stat for:
# - PID, PPID
# - CPU usage
# - Memory usage
# - Process state
# - Command line
```

## Notes

- CPU percentage calculated since process start
- Memory shown in MB
- Default sort by PID
- Filter is case-insensitive substring match