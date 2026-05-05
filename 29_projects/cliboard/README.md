# cliboard - Clipboard History Manager

Clipboard history manager for Wayland (wl-copy/wl-paste) or X11 (xclip).

## Usage

```bash
cliboard <command> [arguments]
```

### Commands

| Command | Description |
|---------|-------------|
| `history` | Show clipboard history |
| `add` | Add current clipboard content to history |
| `get` | Print current clipboard content |
| `select <N>` | Copy history item #N to clipboard |
| `copy <N>` | Copy history item #N to clipboard |
| `pin <N>` | Pin history item #N (keeps at top) |
| `unpin <N>` | Remove pin from item #N |
| `pins` | Show pinned items |
| `search <query>` | Search clipboard history |
| `clear` | Clear all history |
| `watch` | Watch clipboard for changes (background mode) |
| `config` | Manage configuration |

## Configuration

### Config Commands

```bash
cliboard config set <key> <value>  # Set a config value
cliboard config get <key>          # Get a config value
cliboard config list               # Show all config
```

### Config Keys

| Key | Description | Default |
|-----|-------------|---------|
| `max_history` | Maximum items in history | 100 |

### Examples

```bash
# Set max history items
cliboard config set max_history 50

# Get current value
cliboard config get max_history
# 100

# Show all config
cliboard config list
# {
#   "max_history": 100
# }
```

## Data Storage

- History: `~/.config/cliboard/history.json`
- Pins: `~/.config/cliboard/pins.json`
- Config: `~/.config/cliboard/config.json`

## Dependencies

- **Wayland**: `wl-copy`, `wl-paste` (from wl-clipboard package)
- **X11**: `xclip` (fallback)

## Installation

```bash
# Copy to PATH
cp cliboard ~/.local/bin/

# Make executable
chmod +x ~/.local/bin/cliboard
```

## Autostart (Wayland)

Add to your niri/sway config:

```kdl
// niri config.kdl
SpawnProcess "cliboard" ["watch"]
```

Or systemd user service:

```ini
# ~/.config/systemd/user/cliboard.service
[Unit]
Description=Clipboard history watcher

[Service]
ExecStart=%h/.local/bin/cliboard watch
Restart=always

[Install]
WantedBy=default.target
```

```bash
systemctl --user enable --now cliboard
```

## Notes

- History is deduplicated (newest copy stays at top)
- Maximum history size configurable (default: 100)
- Pinned items persist across sessions
- Works with text content only