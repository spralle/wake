# wake

Cross-platform dotfiles managed with [chezmoi](https://chezmoi.io).

Supports **Windows** (PowerShell) and **Arch Linux** (zsh).

## Quick Start

### New machine setup

```bash
# Install chezmoi and apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply spralle/wake --branch develop
```

On Windows (PowerShell):
```powershell
# Install chezmoi
winget install twpayne.chezmoi
# Or: choco install chezmoi

# Init and apply
chezmoi init --apply spralle/wake --branch develop
```

### Daily usage

```bash
chezmoi update          # Pull latest and apply
chezmoi diff            # Preview changes before applying
chezmoi apply           # Apply without pulling
chezmoi edit ~/.zshrc   # Edit a managed file
chezmoi add ~/.ssh/config  # Start managing a new file
```

### Adding secrets

```bash
chezmoi add --encrypt ~/.config/sensitive-file
```

## Structure

- `dot_*` — Files mapped to `$HOME` via chezmoi naming conventions (`dot_` becomes `.`)
- `dot_config/opencode/` — OpenCode agents, principles, and global config
- `packages/` — Declarative package lists for Arch Linux and Windows
- `.chezmoiscripts/` — Auto-run scripts for package installation
- `.chezmoiexternal.toml` — External dependencies (LazyVim, oh-my-zsh)

## What's managed

- **Shell**: zsh + oh-my-zsh (Linux), PowerShell (Windows), Starship prompt (both)
- **Terminal**: tmux (Linux), Windows Terminal (Windows)
- **AI tools**: OpenCode agents/prompts/principles, GitHub Copilot instructions
- **Git**: Global gitconfig, gitignore, delta diff viewer
- **Dev tools**: mise, LazyVim, VS Code, EditorConfig, npm
- **CLI**: ripgrep, bat, lazygit, fzf
- **Packages**: pacman (Arch), winget (Windows)
- **SSH**: Config (no keys — those stay local)
