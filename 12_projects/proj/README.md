# proj - Project Jumper

Fast project directory switcher with fuzzy matching.

## Usage

```bash
proj <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `add <path>` | Add project |
| `remove <name>` | Remove project |
| `scan <dir>` | Auto-discover git repos |
| `list`, `ls` | List all projects |
| `<name>` | Output project path (for cd) |
| `path <name>` | Show project path |
| `edit <name>` | Open in $EDITOR |
| `run <name> <cmd>` | Run command in project |
| `refresh` | Update project metadata |
| `clean` | Remove deleted projects |
| `info <name>` | Show project info |

### Options

| Option | Description |
|--------|-------------|
| `-s, --sort FIELD` | Sort by: recent, name, count |
| `-f, --format FMT` | Output: path, json, full |
| `-h, --help` | Show help |

## Shell Integration

Add to your shell config (`~/.bashrc`, `~/.zshrc`):

```bash
# Bash/Zsh
p() { cd "$(proj "$@")"; }

# Usage
p myapp        # Jump to myapp
p list         # List projects
p add ~/projects/newproject
```

## Examples

### Adding Projects

```bash
# Add single project
proj add ~/projects/myapp

# Add current directory
proj add .

# Auto-discover projects
proj scan ~/projects
proj scan ~/code --depth 3  # Scan 3 levels deep
```

### Jumping to Projects

```bash
# Fuzzy match
p myapp        # Jumps to myapp
p m            # Jumps to first project starting with 'm'

# List all
proj list

# Filter by name
proj list my

# Filter by language
proj list --lang=ruby
```

### Project Info

```bash
proj info myapp
# myapp
# Path: /home/user/projects/myapp
# Language: ruby
# Git root: /home/user/projects/myapp
# Added: 2026-04-01
# Last accessed: 2026-04-12 08:30
# Access count: 15
```

### Running Commands

```bash
# Open in editor
proj edit myapp

# Run command in project directory
proj run myapp "git status"
proj run myapp "bundle install"
```

## Project Detection

Automatically detects project type by checking:

| Indicator | Language |
|-----------|----------|
| `Gemfile`, `*.rb` | Ruby |
| `package.json` | JavaScript |
| `tsconfig.json` | TypeScript |
| `requirements.txt`, `pyproject.toml` | Python |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `mix.exs` | Elixir |

## Storage

Projects stored in `~/.config/proj/projects.json`:

```json
{
  "myapp": {
    "path": "/home/user/projects/myapp",
    "name": "myapp",
    "git_root": "/home/user/projects/myapp",
    "language": "ruby",
    "added_at": "2026-04-01T10:00:00Z",
    "last_accessed": "2026-04-12T08:30:00Z",
    "access_count": 15
  }
}
```

## Performance

- Uses fuzzy character matching for lookup
- Caches project list
- Tracks access frequency for sorting

## Installation

```bash
cp proj ~/.local/bin/
chmod +x ~/.local/bin/proj
```

## Complete Shell Setup

```bash
# ~/.zshrc or ~/.bashrc

# Project jumper function
p() {
    local dir
    dir=$(proj "$@")
    if [[ -n "$dir" && -d "$dir" ]]; then
        cd "$dir"
    fi
}

# Autocompletion (zsh)
_comp_proj() {
    compadd $(proj list 2>/dev/null)
}
compdef _comp_proj proj
```

## Tips

### Common Projects

```bash
# Add frequently used projects
proj add ~/work/project1
proj add ~/work/project2
proj add ~/personal/sideproject

# Scan for all git repos
proj scan ~/work --depth 2
proj scan ~/personal --depth 2
```

### Integration with Other Tools

```bash
# Open in neovim
alias vp='vim $(proj path)'

# Run tests in project
proj run myapp "bundle exec rspec"

# Git operations
proj run myapp "git status"
```