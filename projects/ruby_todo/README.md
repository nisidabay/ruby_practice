# Ruby Todo Application

A command-line todo manager with priorities, categories, and scheduling capabilities.

## Description

This is a Ruby implementation of a todo application, transformed from a Nim codebase. It provides a complete command-line interface for managing todo items with features like:

- Add, edit, and remove todos
- Mark todos as complete
- Set priority levels (high, medium, low)
- Assign categories (computer language, gym, personal)
- Schedule reminders with optional sound notifications
- Persistent storage in JSON format

## Prerequisites

- Ruby 2.7 or higher
- `at` command (for scheduling)
- `mpv` (optional, for sound notifications)

## Installation

1. Clone or download this project
2. Make the executable script runnable:
   ```bash
   chmod +x bin/todo
   ```

3. (Optional) Add to your PATH or create an alias:
   ```bash
   alias todo='/path/to/ruby_todo/bin/todo'
   ```

## Usage

### Basic Commands

```bash
# List all todos
todo list

# Add a new todo
todo add "Buy groceries"

# Mark a todo as complete (1-indexed)
todo done 1

# Remove a todo
todo rm 1

# Edit a todo
todo edit 1 "New task description"
```

### Priority Management

```bash
# Set priority (high, medium, low)
todo priority 1 high
```

### Category Management

```bash
# Set category (computerLanguage, gym, personal)
todo category 2 gym
```

### Scheduling

```bash
# Schedule a reminder (no sound)
todo schedule 1 "tomorrow 9:00"

# Schedule a reminder with sound notification
todo sound 1 "tomorrow 9:00"
```

## File Structure

```
ruby_todo/
├── bin/
│   └── todo              # Executable wrapper
├── todo.rb               # Main application code
└── README.md             # This file
```

## Data Storage

Todos are stored in JSON format at:
- Location: `~/bin/ruby_todos/todos.json`

To reset all todos, simply delete this file and it will be recreated on the next run.

## Sound Notifications

To enable sound notifications with the `sound` command:

1. Ensure `mpv` is installed
2. Place a `bell.mp3` file in `~/bin/ruby_todos/`

## Code Structure

The Ruby implementation includes:

- **Priority Class**: Enum-like class for priority levels (high, medium, low)
- **Category Class**: Enum-like class for categories (computer_language, gym, personal)
- **Todo Class**: Model for individual todo items
- **TodoManager Class**: Handles persistence and CRUD operations
- **TodoCLI Module**: Command-line interface parser

Each method includes a brief explanation comment describing its purpose.

## Examples

```bash
# Create a workout todo
todo add "Go to the gym"
todo category 1 gym
todo priority 1 high

# Create a study todo with reminder
todo add "Learn Ruby metaprogramming"
todo category 2 computerLanguage
todo sound 2 "tomorrow 6:00"

# Complete and remove
todo done 1
todo rm 1
```

## License

This project is open source and available under the MIT License.

## Version History

- **0.0.1**: Initial Ruby implementation (transformed from Nim)