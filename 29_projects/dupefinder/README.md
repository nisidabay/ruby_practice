# dupefinder - Duplicate File Finder

Find duplicate files using size-based pre-filtering and checksums.

## Usage

```bash
dupefinder [directory] [options]
```

### Options

| Option | Description |
|--------|-------------|
| `-d, --delete` | Interactive delete mode |
| `-j, --json` | Output as JSON |
| `-s, --min-size SIZE` | Minimum file size (e.g., `1M`, `500K`) |
| `-v, --verbose` | Verbose output |
| `--dry-run` | Preview deletions |
| `-h, --help` | Show help |

## Examples

```bash
# Find duplicates in Downloads
dupefinder ~/Downloads

# Find duplicates larger than 1MB
dupefinder ~/Downloads --min-size 1M

# Interactive delete
dupefinder ~/Documents --delete

# JSON output for scripting
dupefinder . --json > duplicates.json

# Preview deletions
dupefinder ~/Downloads --delete --dry-run
```

## How It Works

1. **Size scan**: Groups files by size (O(n))
2. **Checksum**: For same-sized files, calculates SHA256 checksums
3. **Report**: Shows duplicate groups with wasted space

## Output Format

```
Found 3 duplicate sets:

[1] Size: 2.5 MB
    1. backup/file1.jpg
    2. Downloads/file1.jpg
    3. temp/file1_copy.jpg

[2] Size: 150 KB
    1. notes.txt
    2. notes_copy.txt

Wasted space: 5.2 MB
```

## JSON Output

```bash
dupefinder --json
```

```json
{
  "abc123...": {
    "size": 2621440,
    "human_size": "2.5 MB",
    "files": ["file1.jpg", "Downloads/file1.jpg", "temp/file1_copy.jpg"]
  }
}
```

## Delete Mode

In delete mode, you'll be prompted for each duplicate group:

```
Group 1 (2.5 MB):
  1. backup/file1.jpg
  2. Downloads/file1.jpg
  3. temp/file1_copy.jpg

Delete which? (number/all but first/skip):
```

- Enter `1` to delete file #1
- Enter `all but first` to keep first file, delete rest
- Enter `skip` to ignore this group

## Ignored Directories

Automatically skips:
- `.git`, `.svn`
- `node_modules`
- `__pycache__`
- `.bundle`, `vendor`
- `.cache`

## Installation

```bash
cp dupefinder ~/.local/bin/
chmod +x ~/.local/bin/dupefinder
```

## Notes

- Uses SHA256 for checksums
- Streams file reading for memory efficiency (8KB chunks)
- Scans recursively by default
- Use `--min-size` to skip small files (faster)