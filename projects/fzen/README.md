# fzen - Fuzzy File Finder

A fast fuzzy file finder with configurable actions, implemented in pure Ruby.

## Usage

```bash
fzen [directory] [options]
```

### Options

| Option | Description |
|--------|-------------|
| `-a, --action ACTION` | Action: open, delete, copy, path (default: open) |
| `-t, --type EXT` | Filter by file extension (e.g., `rb`, `md`) |
| `-H, --hidden` | Show hidden files |
| `--no-preview` | Disable preview |
| `-h, --help` | Show help |

## Features

- **Fuzzy search**: Type partial names to find files quickly
- **Quick actions**: Open, delete, copy path, or output path
- **Git-aware**: Respects `.gitignore` by default
- **Hidden files**: Optional display of dotfiles
- **Extension filter**: Filter by file type

## Examples

```bash
# Find files in current directory (interactive)
fzen

# Find files in specific directory
fzen ~/projects

# Find only Ruby files
fzen --type rb

# Delete selected file
fzen --action delete

# Output file path (useful for scripting)
fzen --action path ~/code | xargs cat

# Include hidden files
fzen --hidden
```

## Keybindings (Interactive Mode)

| Key | Action |
|-----|--------|
| `j/k` | Navigate up/down |
| `Enter` | Execute action |
| `Esc/q` | Quit |
| `Backspace` | Delete character |
| Type | Filter files |

## Dependencies

- Ruby 3.0+
- No external gems required (uses stdlib)

## Installation

```bash
cp fzen ~/.local/bin/
chmod +x ~/.local/bin/fzen
```

## Integration Examples

### With Editor

```bash
# Open file in $EDITOR
vim $(fzen --action path)
```

### With fzf (if you want both)

```bash
# fzen handles simple cases, use fzf for complex ones
alias f='fzen --action path'
```

## Notes

- Uses `Find.find` for recursive directory traversal
- Ignores common directories: `.git`, `node_modules`, `__pycache__`, `.bundle`, `vendor`
- Colors output for better readability