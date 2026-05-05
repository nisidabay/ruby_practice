# tasks - CLI Todo Manager

A minimal but powerful todo manager with priorities, tags, and recurrence.

## Usage

```bash
tasks <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `add`, `a` | Add a new task |
| `list`, `ls`, `l` | List tasks |
| `done`, `d` | Mark task as done |
| `remove`, `rm` | Remove a task |
| `edit`, `e` | Edit a task |
| `note` | Add note to task |
| `show` | Show task details |
| `tag` | Add tags to task |
| `clean` | Remove completed tasks |
| `undo` | Restore completed task |

## Task Options

| Option | Description |
|--------|-------------|
| `-p, --priority LEVEL` | Priority: high, medium, low |
| `-d, --due DATE` | Due date: today, tomorrow, or date |
| `-t, --tags TAGS` | Comma-separated tags |
| `-r, --recur INTERVAL` | Recurring: daily, weekly, monthly |

## Examples

### Adding Tasks

```bash
# Simple task
tasks add "Buy groceries"

# With priority
tasks add "Fix critical bug" --priority high

# With due date
tasks add "Submit report" --due tomorrow
tasks add "Meeting" --due friday

# With tags
tasks add "Review PR #42" --tags work,urgent

# Recurring task
tasks add "Weekly backup" --recur weekly --due monday
```

### Listing Tasks

```bash
# List pending tasks
tasks list

# List all (including completed)
tasks list --all

# Filter by tag
tasks list --tag work

# Filter by priority
tasks list --priority high

# Due today
tasks list --today

# Due this week
tasks list --week

# Overdue tasks
tasks list --overdue
```

### Managing Tasks

```bash
# Complete task
tasks done 1
tasks done 1 2 3    # Complete multiple

# Remove task
tasks remove 5

# Edit task
tasks edit 1 "Updated task title"

# Add note
tasks note 3 "Remember to check API docs"

# Add tags
tasks tag 3 work urgent

# Show task details
tasks show 3

# Clean completed tasks
tasks clean

# Restore completed task
tasks undo 1
```

## Task Display

Tasks are displayed grouped by priority:

```
[HIGH]
  ✓   1 Fix critical bug [work] (today)

[MEDIUM]
     2 Submit report (tomorrow)
     3 Weekly backup [recurring] (friday)

[LOW]
     4 Buy groceries

3 pending, 1 completed, 1 due today
```

## Storage

Tasks stored in `~/.tasks/tasks.json`:

```json
[
  {
    "id": 1,
    "title": "Buy groceries",
    "priority": "medium",
    "status": "pending",
    "tags": ["personal"],
    "due": "2026-04-15",
    "recur": null,
    "notes": [],
    "created_at": "2026-04-12T10:30:00Z"
  }
]
```

## Natural Language Dates

Due dates support natural language:

- `today`, `tomorrow`
- `monday`, `tuesday`, etc.
- `next week`
- `+3` (3 days from now)
- `2026-04-15` (specific date)

## Recurring Tasks

When a recurring task is completed, a new task is automatically created:

```bash
tasks add "Weekly backup" --recur weekly --due monday
# When you complete it, a new task is created for next monday
```

## Git Sync

Since tasks are stored as JSON files:

```bash
cd ~/.tasks
git init
git add tasks.json
git commit -m "Initial tasks"
# Push to remote for sync across machines
```

## Installation

```bash
cp tasks ~/.local/bin/
chmod +x ~/.local/bin/tasks
```

## Shell Alias

```bash
# Add to your shell config
alias t='tasks'
alias ta='tasks add'
alias tl='tasks list'
alias td='tasks done'
```