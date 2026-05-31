# notes - Quick Note Taking

Fast note-taking with search and tagging. Plain text, git-friendly.

## Usage

```bash
notes <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `new`, `n` | Create a new note |
| `list`, `ls`, `l` | List notes |
| `search`, `s` | Search notes |
| `show` | Show note content |
| `edit`, `e` | Edit note in $EDITOR |
| `tag` | Add tags to note |
| `delete`, `rm`, `d` | Delete note |
| `export` | Export notes |
| `sync` | Sync with git |

## Examples

### Creating Notes

```bash
# Quick note
notes new "Fixed bug in auth module"

# With tags
notes new "Meeting notes" --tag work
notes new "API design" -t dev -t planning

# Add tag by number
notes tag 3 work urgent
```

### Viewing Notes

```bash
# List all notes
notes list

# List with tag filter
notes list --tag work

# Search content
notes search "API"
notes search "bug fix"

# Show full note
notes show 5
```

### Editing Notes

```bash
# Edit in $EDITOR
notes edit 3
```

Note file format:
```markdown
# Meeting notes

Discussion points...

---
Tags: work, planning
Created: 2026-04-12 14:30
```

### Managing Notes

```bash
# Add tags
notes tag 5 work urgent

# Clear tags
notes tag 5 --clear

# Delete note
notes delete 7
```

### Exporting

```bash
# Export as text
notes export text

# Export as JSON
notes export json

# Export as markdown
notes export md
```

### Git Sync

```bash
# Initialize git repo
cd ~/.notes
git init
git remote add origin <repo>

# Sync notes
notes sync
```

## Storage

Notes stored in `~/.notes/`:

```
~/.notes/
├── index.json              # Note index
├── 20260412_143000_fixed-bug.md
├── 20260412_150000_meeting-notes.md
└── 20260413_090000_api-design.md
```

### Index Format

`~/.notes/index.json`:

```json
{
  "1": {
    "id": 1,
    "title": "Meeting notes",
    "tags": ["work", "planning"],
    "file": "20260412_143000_meeting-notes.md",
    "created_at": "2026-04-12T14:30:00Z",
    "updated_at": "2026-04-12T15:00:00Z"
  }
}
```

## Note File Format

```markdown
# Title

Content here...

---
Tags: work, urgent
Created: 2026-04-12 14:30
```

## List Options

| Option | Description |
|--------|-------------|
| `-t, --tag TAG` | Filter by tag |
| `-s, --search QUERY` | Search in content |
| `--sort FIELD` | Sort by: date, updated, title |

## Features

- **Plain text**: Notes are markdown files, editable anywhere
- **Git-friendly**: Sync with git for version history
- **Full-text search**: Search note content
- **Tags**: Organize with tags
- **Quick capture**: One-command note creation
- `$EDITOR` integration: Open in your preferred editor

## Installation

```bash
cp notes ~/.local/bin/
chmod +x ~/.local/bin/notes
```

## Shell Alias

```bash
alias n='notes'
alias nn='notes new'
alias ns='notes search'
alias ne='notes edit'
```