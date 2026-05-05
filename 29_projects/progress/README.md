# Progress - Track Files You've Modified

A Ruby TUI to see what text files you've worked on today, yesterday, or any date range. Open files directly in your editor.

## What It Does

Scans your `$HOME` directory for text files modified on a date range and shows them in an interactive TUI. Press `e` to open the selected file in Neovim.

```bash
./progress              # Interactive TUI (default)
./progress today        # Files modified today
./progress yesterday    # Files modified yesterday
./progress week          # Files modified in last 7 days
./progress --from 2024-04-01 --to 2024-04-25
./progress --format json   # JSON output for scripts
```

## The Idea

You work on multiple projects throughout the day — vimwiki notes, Ruby scripts, dotfiles. At the end of the day, you wonder: **"What did I actually work on?"**

This tool answers that question by scanning your home directory for text files and showing which ones were modified, grouped by time.

## TUI (Interactive)

```
┌─────────────────────────────────────────────────────────┐
│ PROGRESS - 2026-04-25 (63 files)                        │
├─────────────────────────────────────────────────────────┤
│ ~/temp/Ruby/progress/scanner.rb     2026-04-25 11:33   │
│ ~/vimwiki/Apuntes-Ruby-blocks.md    2026-04-25 11:28   │
│ ~/temp/Ruby/progress/cli.rb        2026-04-25 11:27   │
│ ...                                                     │
├─────────────────────────────────────────────────────────┤
│ j/k: scroll  e: edit  q: quit                          │
└─────────────────────────────────────────────────────────┘
```

**Keybindings:**
- `j` or `↓` — scroll down
- `k` or `↑` — scroll up
- `e` — edit selected file in nvim (uses `$EDITOR`)
- `q` — quit

---

## Project Structure

```
progress/
├── progress      # Executable (calls CLI.run)
├── cli.rb        # Argument parsing, launches TUI or JSON
├── scanner.rb    # Finds text files in $HOME, filters by date
├── tui.rb        # Interactive terminal UI (curses)
├── formatter.rb  # JSON output
├── Gemfile       # Only curses gem
└── README.md     # This file
```

---

## Data Structures

### File Entry (Hash)

Each file is represented as a simple Hash:

```ruby
{ path: "/home/user/vimwiki/notes.md", mtime: Time.now }
```

- `path` — Full path to the file (String)
- `mtime` — Modification time (Time object)

The scanner returns an Array of these hashes, sorted by `mtime` descending (newest first).

### Options (Hash)

CLI options passed between components:

```ruby
{
  from_date: Date.today,
  to_date: Date.today,
  format: :tui  # or :json
}
```

---

## Patterns Used

### 1. Module Namespacing

Each file defines a single class or module. This keeps things organized without nested directories:

```ruby
# scanner.rb
class Scanner
  def self.scan(...)
    # ...
  end
end

# cli.rb
class CLI
  def self.run(args)
    # ...
  end
end
```

### 2. Class Methods (No Instantiation)

All methods are class methods (`self.method`). No need to instantiate — simpler API:

```ruby
# Call directly
files = Scanner.scan(from_date: Date.today, to_date: Date.today)

# Instead of this
scanner = Scanner.new
files = scanner.scan(...)
```

### 3. Keyword Arguments

Methods use keyword arguments for clarity and flexibility:

```ruby
def self.scan(from_date: nil, to_date: nil, directory: nil)
  # Arguments can be omitted or passed in any order
  Scanner.scan(from_date: Date.today)
  Scanner.scan(directory: "/tmp", from_date: Date.today)
end
```

### 4. Lazy Loading

Curses is only loaded when the TUI is needed. This keeps JSON output fast and dependency-free:

```ruby
if options[:format] == :json
  puts Formatter.format_json(files)
else
  require_relative "tui"  # Only load curses here
  TUI.new(files).run
end
```

### 5. Early Return (Guard Clauses)

Skip invalid data early instead of nesting `if` statements:

```ruby
Find.find(home) do |path|
  # Skip hidden files early
  if hidden_path?(path)
    Find.prune
    next
  end

  next unless File.file?(path)
  next unless text_file?(path)

  # Process valid files...
end
```

### 6. Extension Array (Configuration)

File extensions are defined as a constant — easy to modify:

```ruby
TEXT_EXTENSIONS = %w[
  md txt rb sh py js ts json yaml yml
  html css c h cpp go rs
].freeze
```

---

## Key Ruby Concepts

### Find.find (Directory Walking)

Recursively walks directory tree, like `find` command:

```ruby
require "find"

Find.find("/home/user") do |path|
  if File.directory?(path) && path.include?(".git")
    Find.prune  # Skip this directory
    next
  end

  puts path if File.file?(path)
end
```

### File.mtime (Modification Time)

Returns a `Time` object with file's last modification:

```ruby
mtime = File.mtime("/path/to/file")
puts mtime.year    # 2026
puts mtime.month   # 4
puts mtime.day     # 25
```

### Curses (Terminal UI)

Built-in library for full-screen terminal applications:

```ruby
require "curses"

Curses.init_screen      # Start curses mode
Curses.noecho           # Don't echo keypresses
Curses.cbreak           # Read keys immediately
Curses.stdscr.keypad(true)  # Enable arrow keys
Curses.curs_set(0)      # Hide cursor

Curses.setpos(row, col) # Move cursor
Curses.addstr("text")   # Write text
Curses.getch            # Read one key

Curses.close_screen     # Exit curses
```

### Shellwords (Safe Command Escaping)

Escapes filenames with spaces or special characters:

```ruby
require "shellwords"

file = "/path/to/my notes.md"
system("nvim #{Shellwords.escape(file)}")
# Runs: nvim "/path/to/my notes.md"
```

---

## Reading Order

Learn Ruby by reading these files in order:

1. **`scanner.rb`** (60 lines) — File system operations, date filtering
2. **`formatter.rb`** (50 lines) — JSON formatting, string manipulation
3. **`cli.rb`** (90 lines) — Argument parsing, OptionParser
4. **`tui.rb`** (120 lines) — Curses TUI, event loop, screen rendering
5. **`progress`** (20 lines) — Entry point, just calls `CLI.run`

---

## Karpathy Principles Applied

1. **Simplicity First** — Flat structure, no nested `lib/`, no unnecessary abstractions
2. **Think Before Coding** — Clarified `$HOME` vs `~/vimwiki`, `e` key for editing
3. **Surgical Changes** — Added TUI without breaking JSON output
4. **Goal-Driven** — Test with `./progress` and `./progress --format json`

---

## Installation

```bash
cd progress
bundle install
```

Only dependency: `curses` gem (Ruby's terminal UI library).