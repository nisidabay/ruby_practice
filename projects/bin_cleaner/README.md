# bin_cleaner — Find and Remove Compiled ELF Binaries

A real-world CLI tool that scans a directory tree for Nim/C compiled
ELF binaries and removes them. Demonstrates how **OptionParser** and
**regex** work together in a practical sysadmin script.

## What It Teaches

| Concept | Group | How It's Used |
|---------|-------|---------------|
| `OptionParser` | 01 | `--help`, `--list`, `--yes` flags |
| Regex: lazy quantifier `.+?` | 02 | Captures file path BEFORE `: ` delimiter |
| Regex: non-capturing `(?:...)` | 02 | Optional `pie ` without polluting match data |
| Regex: anchoring `^` | 02 | Ensures match starts at line beginning |
| `FileUtils` | 05 | Safe file deletion |
| Backticks + `find -exec` | 15 | Batch `file` command for performance |

## Usage

```bash
# List what would be deleted (safe)
ruby bin_cleaner.rb --list

# Interactive: list + confirm
ruby bin_cleaner.rb

# Delete without asking
ruby bin_cleaner.rb --yes
```

## How It Works

Instead of checking file permissions (which would catch shell scripts,
Python scripts, etc.), `bin_cleaner` uses the `file` command which reads
a file's **magic header bytes**:

```
$ file /usr/bin/curl
/usr/bin/curl: ELF 64-bit LSB pie executable, x86-64, ...
```

The regex `/^(.+?):\s+ELF 64-bit LSB (?:pie )?executable/` matches only
real compiled binaries. The lazy `.+?` ensures filenames with colons
don't break the match.

## The Regex in Detail

```ruby
ELF_REGEX = /^(.+?):\s+ELF 64-bit LSB (?:pie )?executable/
```

| Token | Meaning |
|-------|---------|
| `^` | Start of line |
| `(.+?)` | Capture path (lazy — stop at first `:`) |
| `:\s+` | Separator between path and type |
| `ELF 64-bit LSB` | ELF magic for 64-bit Linux |
| `(?:pie )?` | Optional PIE (position-independent) — non-capturing |
| `executable` | Must be an executable, not a relocatable `.o` or shared lib |

## Variations to Try

- Add `--dir PATH` flag to scan a specific directory instead of `.`
- Add `--dry-run` that shows what WOULD be deleted without acting
- Add `--except FILE` to skip certain paths
- Modify the regex to find shared libraries (`shared object`) or object files (`.o`)
