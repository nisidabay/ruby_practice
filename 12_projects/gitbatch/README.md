# gitbatch - Batch Git Operations

Run git commands across multiple repositories.

## Usage

```bash
gitbatch <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `status`, `st` | Show status of all repos |
| `pull` | Pull all repos |
| `push` | Push all repos |
| `fetch` | Fetch all repos |
| `commit` | Commit changes in all dirty repos |
| `add <path>` | Add repo to tracking |
| `remove <name>` | Remove repo from tracking |
| `list`, `ls` | List tracked repos |
| `scan <dir>` | Scan for git repos |
| `clean` | Remove invalid repos |
| `info <name>` | Show repo details |

### Options

| Option | Description |
|--------|-------------|
| `-p, --parallel N` | Parallel threads (default: 4) |
| `-d, --dir DIR` | Base directory |
| `-f, --filter PATTERN` | Filter repos by name |
| `--dirty` | Only dirty repos |
| `--behind` | Only repos behind remote |
| `-h, --help` | Show help |

## Examples

### Setup

```bash
# Scan for git repos
gitbatch scan ~/projects

# Add specific repos
gitbatch add ~/projects/myapp
gitbatch add ~/projects/another

# List tracked repos
gitbatch list
```

### Status Check

```bash
# Quick status of all repos
gitbatch status
# myapp    ✓ main
# api      ✗ develop (behind 3)
# frontend ✓ master (ahead 1)

# Check status with details
gitbatch status --verbose

# Filter by name
gitbatch status --filter work
```

### Sync Operations

```bash
# Pull all repos in parallel
gitbatch pull

# Push all repos
gitbatch push

# Fetch all (check for updates)
gitbatch fetch
```

### Batch Commit

```bash
# Commit all dirty repos with message
gitbatch commit "WIP: weekly sync"

# Dry run (show what would be committed)
gitbatch commit "message" --dry-run
```

### Arbitrary Commands

```bash
# Run any git command across repos
gitbatch stash
gitbatch checkout main
gitbatch branch -a
```

## Output Format

```
Repository                 Status Branch       Sync
myapp                      ✗      main         
api                        ✓      develop      behind 3
frontend                   ✓      master       ahead 1
dotfiles                   ✓      main         

4 repos: 1 dirty, 1 behind, 1 ahead
```

Status indicators:
- `✓` Clean working tree
- `✗` Dirty (uncommitted changes)
- `↓` Behind remote
- `↑` Ahead of remote

## Parallel Execution

Process multiple repos concurrently:

```bash
# Default: 4 threads
gitbatch pull

# Custom parallelism
gitbatch pull --parallel 8
gitbatch status -p 2
```

## Configuration

Repos stored in `~/.config/gitbatch/repos.json`:

```json
[
  "/home/user/projects/myapp",
  "/home/user/projects/api",
  "/home/user/projects/frontend"
]
```

## Installation

```bash
cp gitbatch ~/.local/bin/
chmod +x ~/.local/bin/gitbatch
```

## Common Workflows

### Morning Routine

```bash
# Check what needs attention
gitbatch status

# Update all repos
gitbatch pull

# Check for repos behind
gitbatch status --behind
```

### Before Leaving

```bash
# Commit all changes
gitbatch commit "End of day"

# Push to remote
gitbatch push

# Verify clean state
gitbatch status
```

### Weekly Cleanup

```bash
# Clean invalid repos
gitbatch clean

# Rescan for new repos
gitbatch scan ~/projects

# Prune merged branches
gitbatch branch --merged | xargs -I{} git branch -d {}
```

## Dependencies

- Ruby 3.0+
- `parallel` gem (optional, falls back to sequential)

## Installation With Parallel

```bash
gem install parallel
```

## Tips

### Alias

```bash
# Add to shell config
alias gs='gitbatch status'
alias gp='gitbatch pull'
alias gP='gitbatch push'
alias gC='gitbatch commit'
```

### Integration with `proj`

```bash
# Use proj to find repos
gitbatch add $(proj path myapp)
```