# git-helper

A Ruby CLI tool to validate Git commit messages against Conventional Commits
format.

## Installation

### Requirements
- Ruby 2.7+
- Git

### Setup

1. **Clone or copy the script:**
   ```bash
   # Option 1: Copy to your bin directory
   cp git-helper.rb ~/bin/git-helper.rb
   chmod +x ~/bin/git-helper.rb

   # Option 2: Add to your PATH
   # Add to your ~/.bashrc or ~/.zshrc:
   export PATH="$HOME/bin:$PATH"
   ```

2. **Create a config file (optional):**
   ```bash
   # Create .githelper.yml in your project root
   cat > .githelper.yml << EOF
   types:
     - feat
     - fix
     - docs
     - style
     - refactor
     - perf
     - test
     - build
     - ci
     - chore
     - revert
     - integration
   EOF
   ```

### Install as Git Hook (Recommended)

```bash
# From your project root
cd /path/to/your/project
ruby /path/to/git-helper.rb install-hook
```

This creates a pre-push hook that validates commits before pushing.

## Usage

### Check Commits

```bash
# Check unpushed commits (default)
git-helper.rb check

# Check specific range
git-helper.rb check --range "HEAD~10..HEAD"

# Check ALL commits in repository
git-helper.rb check --all
```

### Sanity Check (Full Repository Audit)

```bash
# Full repository scan with statistics
git-helper.rb sanity

# Show pattern summary instead of individual commits
git-helper.rb sanity --summary
```

Output example:
```
🔍 Sanity check: Scanning all commits in the repository...

📊 Repository Statistics:
   Total commits: 2978
   Compliant: 1 (0.03%)
   Non-compliant: 2977 (99.97%)

❌ 2977 commits need fixing:

📋 Format: type: description or type(scope): description
📌 Valid types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert, integration

📊 Pattern analysis:
   "Modify ..." (847 commits)
      → Consider: chore: ...
   "Add ..." (523 commits)
      → Consider: feat: ...
   "Delete ..." (312 commits)
      → Consider: chore: ...
```

### Install/Uninstall Git Hook

```bash
# Install pre-push hook
git-helper.rb install-hook

# Remove hook
git-helper.rb uninstall-hook
```

### View Help

```bash
git-helper.rb help
git-helper.rb help check
git-helper.rb help sanity
```

## Conventional Commits Format

Valid commit messages must follow this format:

```
type: description
type(scope): description
type!: description  (breaking change)
type(scope)!: description
```

### Valid Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation changes |
| `style` | Code style (formatting, semicolons, etc.) |
| `refactor` | Code refactoring |
| `perf` | Performance improvement |
| `test` | Adding/updating tests |
| `build` | Build system changes |
| `ci` | CI configuration changes |
| `chore` | Maintenance tasks |
| `revert` | Revert previous commit |
| `integration` | Integration changes |

### Examples

```bash
# Good commits
feat: add user authentication
fix(api): handle timeout errors
docs: update README with installation steps
refactor(utils): simplify date formatting
chore: remove deprecated functions

# Bad commits (will fail validation)
Add user authentication
Fixed bug in API
update readme
refactored code
cleanup
```

## Configuration

Create `.githelper.yml` in your project root:

```yaml
# Custom types (optional, defaults shown)
types:
  - feat
  - fix
  - docs
  - style
  - refactor
  - perf
  - test
  - build
  - ci
  - chore
  - revert
  - integration
```

The tool will search for `.githelper.yml` in the current directory and parent directories.

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All commits pass validation |
| 1 | One or more commits fail validation |

## Examples in Practice

### Pre-push Hook Workflow

```bash
# 1. Make commits with conventional format
git commit -m "feat: add new feature"
git commit -m "fix: resolve bug"

# 2. Push (hook validates automatically)
git push origin main
# ✅ Push succeeds

# 3. If you have bad commits
git commit -m "Add stuff"  # Bad format
git push origin main
# ❌ Push blocked: Commit messages don't follow Conventional Commits format.
#    Fix your commits with: git rebase -i
```

### Fixing Bad Commits

```bash
# Check what's wrong
git-helper.rb check

# Interactive rebase to fix
git rebase -i HEAD~3

# In editor, change 'pick' to 'reword' for bad commits
# Save and enter conventional commit messages

# Verify fix
git-helper.rb check
```

### CI/CD Integration

```yaml
# GitHub Actions example
- name: Validate Commits
  run: |
    ruby git-helper.rb check --all
    if [ $? -ne 0 ]; then
      echo "Commit messages must follow Conventional Commits format"
      exit 1
    fi
```

## License

MIT License

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/my-feature`
3. Commit with conventional format: `git commit -m "feat: add my feature"`
4. Push and submit a pull request
