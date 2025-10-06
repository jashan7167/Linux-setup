# fzf Minimal Setup Guide

A minimal, efficient setup for fzf (fuzzy finder) on Linux Mint/Ubuntu/Debian.

## Installation

### Install Required Tools

```bash
# Install fzf and dependencies
sudo apt install fzf fd-find ripgrep bat xclip

# Create symlink for fd (it installs as 'fdfind' on Debian-based systems)
mkdir -p ~/.local/bin
ln -s $(which fdfind) ~/.local/bin/fd

# Verify installation
fd --version
fzf --version
```

## Configuration

Add this to your `~/.zshrc` or `~/.bashrc`:

```bash
# Enable fzf shell integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Configure fzf to use fd for better file searching
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Set default fzf options
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border --preview "bat --color=always {}" --preview-window right:60%:wrap'
```

Reload your shell:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

## Usage

### Built-in Keybindings (Work anywhere in terminal)

| Keybinding | Function |
|------------|----------|
| `Ctrl-t` | Search files and paste path to command line |
| `Ctrl-r` | Search command history |
| `Alt-c` | Search directories and cd into selected one |

### Inside fzf Interface

| Keybinding | Function |
|------------|----------|
| `Ctrl-j` / `Ctrl-k` | Move down/up |
| `Ctrl-/` | Toggle preview window |
| `Ctrl-u` / `Ctrl-d` | Scroll preview up/down |
| `Tab` | Select item (multi-select mode) |
| `Shift-Tab` | Deselect item |
| `Enter` | Confirm selection |
| `Esc` | Cancel |

### Search Patterns

| Pattern | Description | Example |
|---------|-------------|---------|
| `fuzzy` | Fuzzy match (default) | `readme` matches `README.md` |
| `'exact` | Exact match | `'config.json` |
| `^prefix` | Start with | `^test` matches `test_file.py` |
| `suffix$` | End with | `.md$` matches all markdown files |
| `!exclude` | Exclude | `python !test` excludes files with "test" |

### Command Usage

```bash
# Search files and open in vim
vim $(fd --type f | fzf)

# Search and copy file path
fd --type f | fzf | xclip -selection clipboard

# Multi-select files (Tab to select, Enter to confirm)
fd --type f | fzf -m

# Search specific file types
fd -e pdf | fzf
fd -e "jpg|png|gif" | fzf

# Search in specific directory
fd --type f . ~/projects | fzf

# Search file contents with ripgrep
rg --color=always --line-number "search term" | fzf --ansi
```

## What Each Tool Does

| Tool | Purpose |
|------|---------|
| **fzf** | Interactive fuzzy finder - filters and selects from any list |
| **fd** | Fast file finder (alternative to `find`) - generates file lists |
| **ripgrep** | Fast text search (alternative to `grep`) - searches inside files |
| **bat** | Syntax-highlighted file viewer (alternative to `cat`) - shows file previews |
| **xclip** | Clipboard manager - copies text to clipboard |

## Workflow Examples

### Find and Edit File
```bash
# Press Ctrl-t, type filename, Enter
vim [Ctrl-t]
```

### Search Command History
```bash
# Press Ctrl-r, type command, Enter
[Ctrl-r]
```

### Navigate to Directory
```bash
# Press Alt-c, select directory, Enter
[Alt-c]
```

### Search Inside Files
```bash
# Search for "function" in all files
rg --color=always --line-number "function" | fzf --ansi
```

## Troubleshooting

### Alt-c doesn't work
Some terminals don't send `Alt` properly. Try:
- Press `Esc` then `c` (quickly, one after another)
- Or check your terminal's keyboard settings

### fd not found
If you get "command not found", the symlink wasn't created properly:
```bash
# Check if fdfind exists
which fdfind

# Recreate symlink
mkdir -p ~/.local/bin
ln -sf $(which fdfind) ~/.local/bin/fd

# Ensure ~/.local/bin is in PATH
echo $PATH | grep ".local/bin"
```

### Preview not showing
Install bat:
```bash
sudo apt install bat
```

## Tips for Practice

1. **Start with `Ctrl-t`** - Use it instead of typing file paths manually
2. **Use `Ctrl-r`** - Search command history instead of pressing Up arrow
3. **Try `Alt-c`** - Navigate directories quickly
4. **Type while searching** - The fuzzy matching is smart, just type parts of the filename

## Next Steps

Once comfortable with the basics:
- Explore custom keybindings with `--bind`
- Create shell functions for common workflows
- Integrate with git, docker, and other tools
- Customize preview commands for different file types

## References

- [fzf GitHub](https://github.com/junegunn/fzf)
- [fd GitHub](https://github.com/sharkdp/fd)
- [ripgrep GitHub](https://github.com/BurntSushi/ripgrep)
- [bat GitHub](https://github.com/sharkdp/bat)
