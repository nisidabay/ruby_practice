# nvimplugin - Neovim Plugin Manager CLI

Manage Neovim plugins from the command line.

## Usage

```bash
nvimplugin <command> [options]
```

### Commands

| Command | Description |
|---------|-------------|
| `add <plugin>` | Add a plugin |
| `remove`, `rm` | Remove a plugin |
| `list`, `ls` | List installed plugins |
| `search <query>` | Search plugins |
| `update [plugin]` | Update plugin(s) |
| `check` | Check for updates |
| `health` | Run health checks |
| `clean` | Clean unused plugins |
| `info <plugin>` | Show plugin info |
| `sync` | Sync plugins |

### Options

| Option | Description |
|--------|-------------|
| `-c, --config FILE` | Config file to use |
| `--dry-run` | Preview without changes |
| `-h, --help` | Show help |

## Adding Plugins

### Basic Usage

```bash
# Add plugin
nvimplugin add "nvim-treesitter/nvim-treesitter"

# Add with lazy loading
nvimplugin add "nvim-telescope/telescope.nvim" --event VeryLazy

# Add with command
nvimplugin add "tpope/vim-fugitive" --cmd "Git"

# Add with dependencies
nvimplugin add "neovim/nvim-lspconfig" -d "hrsh7th/nvim-cmp"

# Add with setup
nvimplugin add "echasnovski/mini.surround" --config
```

### Plugin Specification

```bash
nvimplugin add "author/plugin-name" -e VeryLazy -d "dep1,dep2"
```

Options:
- `-e, --event`: Lazy load on event (VeryLazy, BufRead, etc.)
- `-c, --cmd`: Lazy load on command
- `-d, --dependencies`: Comma-separated dependencies
- `--config`: Generate config function

## Managing Plugins

```bash
# List installed plugins
nvimplugin list

# Search for plugins
nvimplugin search telescope

# Remove plugin
nvimplugin remove "vim-airline/vim-airline"

# Update specific plugin
nvimplugin update nvim-treesitter

# Update all plugins
nvimplugin update

# Check for updates (no sync)
nvimplugin check

# Sync plugins
nvimplugin sync

# Clean unused
nvimplugin clean
```

## Configuration Structure

Plugins stored in `~/.config/nvim/lua/plugins/`:

```
~/.config/nvim/lua/plugins/
├── init.lua
├── treesitter.lua
├── lsp.lua
├── completion.lua
└── telescope.lua
```

### Generated Spec

When adding plugins, generates lazy.nvim spec:

```lua
-- ~/.config/nvim/lua/plugins/init.lua
{
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      highlight = { enable = true },
    })
  end,
}
```

## Plugin Search

Searches popular Neovim plugins:

```bash
nvimplugin search treesitter
# nvim-treesitter/nvim-treesitter
# nvim-treesitter/nvim-treesitter-textobjects
# ...

nvimplugin search "lsp"
# neovim/nvim-lspconfig
# hrsh7th/nvim-cmp
# ...
```

For comprehensive search, use:
- nvim.io
- github.com/topics/neovim-plugin

## Examples

### Add Language Support

```bash
# LSP
nvimplugin add "neovim/nvim-lspconfig" --event VeryLazy

# Treesitter
nvimplugin add "nvim-treesitter/nvim-treesitter" --event VeryLazy

# Completion
nvimplugin add "hrsh7th/nvim-cmp" --event InsertEnter
```

### Add Editor Tools

```bash
# Fuzzy finder
nvimplugin add "nvim-telescope/telescope.nvim"
nvimplugin add "nvim-telescope/telescope-fzf-native.nvim"

# Git
nvimplugin add "lewis6991/gitsigns.nvim"

# Status line
nvimplugin add "nvim-lualine/lualine.nvim"
```

### Manage Existing

```bash
# Check what's installed
nvimplugin list

# Find unused (heuristic)
nvimplugin unused

# Clean up
nvimplugin clean

# Check health
nvimplugin health
```

## Installation

```bash
cp nvimplugin ~/.local/bin/
chmod +x ~/.local/bin/nvimplugin
```

## Dependencies

- Neovim 0.8+
- lazy.nvim plugin manager

## Notes

- Edits lua plugin files directly
- Maintains lazy.nvim spec format
- Groups plugins by category into separate files (treesitter.lua, lsp.lua, etc.)
- Uses `$EDITOR` or `nano` to edit plugin files

## Manual Sync

After adding/removing plugins:

```bash
# Start neovim and sync
nvim --headless '+Lazy! sync' +q
```

Or use:

```bash
nvimplugin sync
```