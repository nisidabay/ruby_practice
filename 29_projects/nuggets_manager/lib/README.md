# rnuggets

Show code snippets and GNU tools — the Ruby rewrite of personal
project "pynuggets".

A terminal-based "snippet of the day" manager. Browse, search, and rotate
through collections of code/terminal tips stored as flat `.txt` files.

## Usage

```
rnuggets              # Show snippet of the day
rnuggets -c           # Change default nugget
rnuggets -f           # Search across nuggets
rnuggets -l           # List available nuggets
rnuggets -n           # Create new nugget
rnuggets -e           # Edit a nugget
rnuggets -d           # Delete a nugget
rnuggets -m           # Merge all nuggets into one file
rnuggets -R           # Pick a random nugget
rnuggets -s           # Show current default nugget info
rnuggets -h           # Show help
rnuggets --version    # Show version
```

## Dependencies

- Ruby 3.x (stdlib only — no external gems)
- `fzf` — fuzzy finder for interactive selection
- `xdg-open` — opening file links
- `nvim` (or `$EDITOR`) — editing nugget files

## License

MIT — see [LICENSE](LICENSE). Copyright (c) 2022 nisidabay.
