# Skill Registry — git_helper

Generated: 2026-03-15

## Available Skills

### Project Stack
| Skill | Trigger | Location |
|-------|---------|----------|
| ruby | Writing, reviewing, or debugging Ruby code | `~/.config/opencode/skills/ruby/SKILL.md` |
| bash-scripting | Writing or debugging shell scripts | `~/.config/opencode/skills/bash-scripting/SKILL.md` |

### SDD Skills
| Skill | Description | Location |
|-------|-------------|----------|
| sdd-init | Initialize SDD in a project | `~/.config/opencode/skills/sdd-init/SKILL.md` |
| sdd-explore | Explore ideas before committing to a change | `~/.config/opencode/skills/sdd-explore/SKILL.md` |
| sdd-propose | Create a change proposal | `~/.config/opencode/skills/sdd-propose/SKILL.md` |
| sdd-spec | Write specifications with requirements | `~/.config/opencode/skills/sdd-spec/SKILL.md` |
| sdd-design | Create technical design document | `~/.config/opencode/skills/sdd-design/SKILL.md` |
| sdd-tasks | Break down a change into tasks | `~/.config/opencode/skills/sdd-tasks/SKILL.md` |
| sdd-apply | Implement tasks from a change | `~/.config/opencode/skills/sdd-apply/SKILL.md` |
| sdd-verify | Verify implementation against specs | `~/.config/opencode/skills/sdd-verify/SKILL.md` |
| sdd-archive | Archive a completed change | `~/.config/opencode/skills/sdd-archive/SKILL.md` |

## Project Conventions

No project-level convention files found (no agents.md, CLAUDE.md, .cursorrules, etc.).

## How to Load Skills

As a sub-agent, load skills BEFORE starting your task:

1. **Engram first** (fastest, cross-session):
   ```
   mem_search(query: "skill-registry", project: "git_helper")
   → mem_get_observation(id)
   ```

2. **Filesystem fallback**:
   ```
   read .atl/skill-registry.md
   ```

3. **Read relevant SKILL.md files** based on your task:
   - Ruby code → load ruby skill
   - Shell scripts → load bash-scripting skill

## Skill Details

### ruby
- **Verification**: `ruby -c {file}` (syntax), `rubocop -a {file}` (style)
- **Headers**: `#!/usr/bin/env ruby`, `# frozen_string_literal: true`
- **Naming**: snake_case methods/variables, CamelCase classes
- **Testing**: RSpec with `describe`/`context`/`it` structure

### bash-scripting
- See `~/.config/opencode/skills/bash-scripting/SKILL.md` for full details