# Projects — Real-World Ruby Toolbox

30+ CLI tools built in Ruby. Each project applies concepts from the numbered groups (01-11).

## Quick Reference: Tool → Groups

| Tool | What it does | Concepts used |
|---|---|---|
| `add_documentation` | Add doc comments to Ruby files | 02 (strings), 05 (filesystem) |
| `calculator` | CLI calculator | 01 (basics), 03 (control flow) |
| `cliboard` | Clipboard history manager | 05 (filesystem), process I/O |
| `contacts` | Contact manager with CRUD | 04 (OOP), 05 (filesystem) |
| `cpu_info` | CPU/system info reader | 05 (filesystem — /proc), 02 (strings) |
| `dotbak` | Dotfiles backup + git sync | 05 (filesystem), 08 (time) |
| `dupefinder` | Duplicate file finder | 05 (filesystem), 10 (threads) |
| `format_ruby_files` | Auto-format Ruby files | 05 (filesystem), 02 (regex) |
| `fzen` | Fuzzy file finder (pure Ruby) | 05 (filesystem), 02 (strings) |
| `gemdoctor` | Gem health analyzer | 05 (filesystem), process I/O |
| `gitbatch` | Batch git operations | 05 (filesystem), 10 (threads) |
| `git_helper` | Conventional commit validator | 02 (regex), 05 (filesystem) |
| `gum_ruby` | Gum CLI wrapper in Ruby | process I/O, 01 (basics) |
| `gum_todo_list` | Todo with Gum TUI | process I/O, 05 (filesystem) |
| `kittycmd` | Kitty terminal config generator | 05 (filesystem), 02 (strings) |
| `logwatch` | Log viewer + filter | 05 (filesystem), 10 (threads) |
| `nirilaunch` | Niri compositor launcher | 05 (filesystem), process |
| `notes` | Quick note-taking (plain text) | 05 (filesystem), 02 (strings) |
| `nuggets_manager` | Ruby gem snippet manager | 04 (OOP), 05 (filesystem) |
| `nvimplugin` | Neovim plugin manager CLI | 05 (filesystem), process |
| `pdf_to_text` | PDF text extraction | 05 (filesystem), process |
| `procop` | Process monitor + killer | process I/O, 05 (filesystem) |
| `progress` | File modification tracker (TUI) | 05 (filesystem), 08 (time) |
| `proj` | Project directory jumper | 05 (filesystem), 02 (strings) |
| `renamer` | Bulk file renamer | 05 (filesystem), 02 (regex) |
| `ruby_todo` | Full todo app with priorities | 04 (OOP), 05 (filesystem), 08 (time) |
| `tasks` | Minimal todo with tags | 04 (OOP), 05 (filesystem), 08 (time) |
| `todo_list1` | Simple todo (single file) | 01 (basics), 05 (filesystem) |
| `todo_list2` | Structured todo (classes) | 04 (OOP), 05 (filesystem) |
| `tty` | Terminal/TTY utilities | process I/O, 03 (control flow) |

## By Concept Group

### 02 Strings & Regex
`git_helper`, `renamer`, `format_ruby_files`, `fzen`, `proj`, `kittycmd`, `notes`, `add_documentation`, `cpu_info`

### 03 Control Flow & Collections
`calculator`, `tty`

### 04 OOP
`contacts`, `ruby_todo`, `tasks`, `todo_list2`, `nuggets_manager`

### 05 Filesystem
*Everything* touches the filesystem, but these lean heaviest:
`dotbak`, `dupefinder`, `logwatch`, `progress`, `nirilaunch`, `gitbatch`, `gemdoctor`, `nvimplugin`, `pdf_to_text`, `procop`

### 08 Time
`progress`, `dotbak`, `ruby_todo`, `tasks`

### 10 Threads
`dupefinder`, `gitbatch`, `logwatch`

## Installation

Most tools are self-contained single-file scripts:

```bash
cp <tool>/<tool>.rb ~/.local/bin/<tool>
chmod +x ~/.local/bin/<tool>
```

Check each tool's own README for specific dependencies and setup.
