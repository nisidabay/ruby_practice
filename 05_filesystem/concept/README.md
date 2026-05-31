# Filesystem — Practice Suite

File I/O, directory navigation, temp files, in-memory IO, and real-world scripts.

## Quick Start

```bash
# Reading files
ruby 01_read_all.rb                     # File.read: open, slurp, close
ruby 02_gets_vs_readline.rb             # Safe reading: nil vs EOFError
ruby 03_readlines_vs_each_line.rb       # Eager array vs lazy enumerator
ruby 04_chunked_read.rb                 # Streaming read(N) for large files
ruby 05_binread.rb                      # Binary-safe reading

# Writing files
ruby 08_file_write.rb                   # File.write: create or overwrite

# Path handling
ruby 06_expand_path.rb                  # Relative → absolute paths
ruby 07_file_checks.rb                  # exist? / file? / directory?

# In-memory & temp
ruby 14_stringio.rb                     # Fake IO in memory
ruby 15_tempfile_tmpdir.rb              # Self-cleaning temp resources

# Real-world scripts
ruby app_launcher.rb                    # fzf-powered .desktop launcher
ruby file_system_navigation.rb          # Interactive filesystem navigator
```

## Learning Path

### Reading Files (~30 min)

| Script | Concept |
|---|---|
| `01_read_all.rb` | `File.read` — open, slurp, close in one call |
| `02_gets_vs_readline.rb` | `gets` returns nil at EOF; `readline` raises |
| `03_readlines_vs_each_line.rb` | Eager array vs lazy enumerator (memory tradeoffs) |
| `04_chunked_read.rb` | `read(N)` streams chunks for large files |
| `05_binread.rb` | `binread` preserves every byte (images, binaries) |

### Writing Files (~15 min)

| Script | Concept |
|---|---|
| `08_file_write.rb` | `File.write` — create or overwrite in one line |

### Path & Metadata (~20 min)

| Script | Concept |
|---|---|
| `06_expand_path.rb` | Turn relative paths into absolute paths |
| `07_file_checks.rb` | `exist?` / `file?` / `directory?` |
| `13_file_metadata.rb` | `stat` without opening: size, mtime, atime |
| `pathname_tour.rb` | `Pathname` — OOP replacement for File, Dir, IO |

### Error Handling (~20 min)

| Script | Concept |
|---|---|
| `09_rescue_io_errors.rb` | Catch specific `Errno` classes |
| `10_safe_io_wrapper.rb` | Yield wrapper that rescues IO errors once |
| `12_scan_unreadable.rb` | Scan directory for unreadable files |

### In-Memory & Temp IO (~20 min)

| Script | Concept |
|---|---|
| `14_stringio.rb` | Fake IO in memory — test file code without disk |
| `15_tempfile_tmpdir.rb` | `Tempfile` and `Dir.mktmpdir` — self-cleaning |

### Directory & FileUtils (~25 min)

| Script | Concept |
|---|---|
| `dir.rb` | `Dir` — list, chdir, glob |
| `11_recursive_delete.rb` | Delete directory trees, symlinks handled |
| `16_fileutils.rb` | `FileUtils` — cp, mv, rm, mkdir_p, chmod |

### Real-World Scripts (~20 min)

| Script | Concept |
|---|---|
| `app_launcher.rb` | Find + launch .desktop entries via fzf |
| `file_system_navigation.rb` | Interactive navigator with cursor keys |
| `check_service.rb` | Systemd service health checks |
| `backup_ruby_files.rb` | Selective file backup script |
| `archive_large_logs.rb` | Log rotation + compression |

## Common Patterns

```ruby
# Read entire file
content = File.read("file.txt")

# Read line by line (memory-efficient)
File.foreach("huge.log") { |line| puts line }

# Write
File.write("out.txt", "content")

# Path resolution
abs = File.expand_path("~/config.yml")   # => /home/user/config.yml
File.exist?(abs)                          # => true/false
File.directory?(abs)                      # => true/false

# Temp file (auto-cleaned)
require "tempfile"
Tempfile.create(["prefix", ".txt"]) { |f| f.write("data") }

# In-memory IO
require "stringio"
io = StringIO.new("hello\nworld")
io.gets                                   # => "hello\n"
```
