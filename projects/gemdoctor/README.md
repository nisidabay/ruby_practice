# gemdoctor - Ruby Gem Health Check

Analyze and manage your Ruby gems.

## Usage

```bash
gemdoctor <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `audit` | Check for vulnerabilities and updates |
| `outdated` | List outdated gems |
| `unused` | Find potentially unused gems |
| `update` | Update gems |
| `clean` | Remove old gem versions |
| `list`, `ls` | List installed gems |
| `check` | Run security checks |

### Options

| Option | Description |
|--------|-------------|
| `-s, --severity LEVEL` | Minimum severity: critical, high, medium, all |
| `-j, --json` | JSON output |
| `-d, --dry-run` | Preview changes |
| `--no-bundle` | Skip bundler checks |
| `-h, --help` | Show help |

## Examples

### Audit

```bash
# Full audit (vulnerabilities + outdated)
gemdoctor audit

# Check specific severity
gemdoctor audit --severity high
gemdoctor audit --severity critical

# JSON output
gemdoctor audit --json > report.json
```

### Outdated Gems

```bash
# List outdated
gemdoctor outdated

# JSON output for scripting
gemdoctor outdated --json
```

### Unused Gems

```bash
# Find potentially unused gems
gemdoctor unused

# Note: This is heuristic-based, verify before removing
```

### Update Gems

```bash
# Update patch versions only (safest)
gemdoctor update patch

# Update minor versions
gemdoctor update minor

# Update to latest (may break)
gemdoctor update major

# Preview updates
gemdoctor update --dry-run
```

### Clean Old Versions

```bash
# Keep last 2 versions
gemdoctor clean

# Keep last 3 versions
gemdoctor clean 3

# Preview removals
gemdoctor clean --dry-run
```

## Output Example

```
Auditing gems...

Vulnerabilities:
  rails 5.2.0: CVE-2022-12345
    Critical vulnerability in ActiveRecord

Outdated gems:
  rails        5.2.0   -> 7.0.4
  rspec-rails  4.0.0   -> 5.1.0
  bundler      2.3.0   -> 2.4.0

Run 'gemdoctor update' to update gems
```

## Security Checks

Uses `bundler-audit` if available:

```bash
gem install bundler-audit
gemdoctor audit
```

Checks against:
- Ruby Advisory Database
- Known CVEs
- Critical security issues

## Usage with Bundler

Most commands work with your `Gemfile`:

```bash
# In a Rails project
cd ~/projects/myapp
gemdoctor audit
gemdoctor outdated
gemdoctor update patch
```

## Installation

```bash
cp gemdoctor ~/.local/bin/
chmod +x ~/.local/bin/gemdoctor

# Optional: install bundler-audit
gem install bundler-audit
```

## Heuristics for Unused Gems

The `unused` command uses heuristic matching:

1. Parses your `Gemfile` for gem names
2. Scans `**/*.rb` files for `require` statements
3. Compares lists

**Limitations:**
- Gems with different require names (e.g., `rspec-rails` requires `rspec`)
- Lazy-loaded gems
- Gems used indirectly

**Always verify before removing.**

## Common Workflows

### Weekly Check

```bash
# Check for updates
gemdoctor audit

# Update patches only (safe)
gemdoctor update patch

# Clean old versions
gemdoctor clean
```

### Pre-Deploy Check

```bash
# Full security audit
gemdoctor audit --severity high

# Ensure no outdated
gemdoctor outdated
```

### New Project Setup

```bash
# Check project gems
cd new-project
gemdoctor audit

# Update to latest patches
gemdoctor update patch
bundle install
```