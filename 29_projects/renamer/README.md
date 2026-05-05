# renamer - Bulk File Renamer

Bulk rename files with regex, templates, and live preview.

## Usage

```bash
renamer [options] <pattern> <replacement> [files...]
renamer --template <template> [files...]
```

### Options

| Option | Description |
|--------|-------------|
| `-t, --template TEMPLATE` | Use template pattern |
| `-d, --dry-run` | Preview changes without applying |
| `-l, --lowercase` | Convert to lowercase |
| `-u, --undo` | Undo last operation |
| `-h, --help` | Show help |

## Template Variables

| Variable | Description |
|----------|-------------|
| `{n}` | Sequential number |
| `{n:03d}` | Zero-padded number (3 digits) |
| `{n:04d}` | Zero-padded number (4 digits) |
| `{date}` | Current date (YYYYMMDD) |
| `{ext}` | File extension (without dot) |
| `{name}` | Original filename (without extension) |
| `{parent}` | Parent directory name |

## Examples

### Regex Replacement

```bash
# Simple regex replacement
renamer 's/old/new/' *.txt

# Remove spaces
renamer 's/\s+/_/g' *

# Change extension
renamer 's/\.txt/\.md/' *.txt
```

### Templates

```bash
# Number files sequentially
renamer --template 'img_{n:03d}.{ext}' *.jpg
# img_001.jpg, img_002.jpg, ...

# Date-based naming
renamer --template 'backup_{date}_{name}.{ext}' *.conf
# backup_20260412_config.conf

# Include parent directory
renamer --template '{parent}_{n}.{ext}' *.pdf
```

### Lowercase

```bash
# Lowercase extensions
renamer --lowercase *.PNG
# file.PNG -> file.png
```

### Preview and Undo

```bash
# Preview without changes
renamer --dry-run 's/test/spec/' *.rb

# Undo last operation
renamer --undo
```

## Features

- **Regex patterns**: Full Ruby regex support (`s/pattern/replacement/`)
- **Templates**: Easy sequential naming with variables
- **Preview**: Shows changes before applying
- **Undo**: History stored in `~/.config/renamer/history.json`
- **Bulk operations**: Process multiple files at once

## Safety

- Always shows preview before renaming
- Requires confirmation to apply changes
- History saved for undo capability
- Dry-run mode available

## Installation

```bash
cp renamer ~/.local/bin/
chmod +x ~/.local/bin/renamer
```

## Notes

- Uses `File.rename` under the hood
- History stored in `~/.config/renamer/history.json`
- Confirmation required by default (use `-d` first to preview)