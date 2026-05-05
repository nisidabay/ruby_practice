# dotbak - Dotfiles Backup Manager

Dotfiles backup and sync with git integration.

## Usage

```bash
dotbak <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `init` | Initialize backup repo |
| `add <file>` | Add file to track |
| `remove <file>` | Stop tracking file |
| `backup` | Sync all tracked files |
| `restore` | Restore from backup |
| `diff <file>` | Show changes |
| `status` | Show tracking status |
| `list`, `ls` | List tracked files |
| `commit` | Git commit changes |
| `push` | Git push to remote |
| `pull` | Git pull from remote |
| `log` | Show git log |

## Examples

### Initial Setup

```bash
# Initialize local repo
dotbak init

# Initialize with remote
dotbak init git@github.com:user/dotfiles.git

# Add files to track
dotbak add ~/.bashrc
dotbak add ~/.config/nvim
dotbak add ~/.config/kitty

# Add all config
dotbak add ~/.config/niri ~/.config/quickshell
```

### Backup and Restore

```bash
# Sync all tracked files
dotbak backup

# Restore all files (after fresh install)
dotbak restore

# Restore specific file
dotbak restore ~/.bashrc

# Restore specific version
dotbak restore ~/.bashrc HEAD~3
```

### Viewing Status

```bash
# Show tracked files status
dotbak status
#   .bashrc [SYNCED]
#   .config/nvim [CHANGED]
#   .config/kitty [DELETED]

# Show diff
dotbak diff ~/.bashrc

# List tracked files
dotbak list
```

### Git Integration

```bash
# Commit with message
dotbak commit "Added kitty config"

# Push to remote
dotbak push

# Pull from remote
dotbak pull

# View history
dotbak log
```

## Storage Structure

```
~/.dotbak/
├── repo/                  # Git repository
│   ├── .git/
│   └── home/
│       └── user/
│           ├── .bashrc
│           └── .config/
│               ├── nvim/
│               └── kitty/
└── history.json           # Backup history
```

Files are stored with full path structure preserved.

## Workflow for Fresh Install

```bash
# 1. Install dotbak
cp dotbak ~/.local/bin/

# 2. Initialize and pull
dotbak init git@github.com:user/dotfiles.git
dotbak pull

# 3. Restore all configs
dotbak restore

# 4. Check status
dotbak status
```

## Daily Workflow

```bash
# Make changes to ~/.config/nvim/init.lua

# Backup changes
dotbak backup

# Commit and push
dotbak commit "Updated nvim config"
dotbak push
```

## Features

- **Selective tracking**: Only track what you need
- **Git integration**: Version history via git
- **Multi-machine sync**: Push/pull between machines
- **Conflict resolution**: Git handles merges
- **Fast restore**: Restore all or specific files

## Installation

```bash
cp dotbak ~/.local/bin/
chmod +x ~/.local/bin/dotbak
```

## Tips

### Automated Backup

Add cron job:

```bash
# Backup every hour
0 * * * * ~/.local/bin/dotbak backup && ~/.local/bin/dotbak commit "Auto backup"
```

### Multiple Machine Setup

```bash
# Machine 1
dotbak init git@github.com:user/dotfiles.git
dotbak add ~/.bashrc
dotbak backup
dotbak commit "Initial backup"
dotbak push

# Machine 2
dotbak init git@github.com:user/dotfiles.git
dotbak pull
dotbak restore
```

### Exclude Patterns

Edit `~/.dotbak/repo/.gitignore`:

```
*.log
*.tmp
.env
secrets/
```