# wake

Cross-platform dotfiles managed with [chezmoi](https://chezmoi.io).

Supports **Windows** (PowerShell) and **Arch Linux** (zsh).

## Install chezmoi

### Linux / macOS / WSL

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### Windows (pick one)

```powershell
# Option 1: winget (recommended)
winget install twpayne.chezmoi

# Option 2: Manual binary (no admin required)
Invoke-WebRequest -Uri "https://github.com/twpayne/chezmoi/releases/latest/download/chezmoi-windows-amd64.exe" -OutFile "$HOME\.local\bin\chezmoi.exe"
# Then add $HOME\.local\bin to your PATH if it isn't already
```

## Quick Start

### New machine setup

```bash
# Linux/macOS — install chezmoi and apply in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply spralle/wake --branch develop
```

```powershell
# Windows — after installing chezmoi (see above)
chezmoi init --apply spralle/wake --branch develop
```

On first run, chezmoi will prompt for:

| Prompt     | What it sets                                    |
|------------|-------------------------------------------------|
| Full name  | Used in `.gitconfig` author name                |
| Email      | Used in `.gitconfig` and npm config              |
| Is work?   | `true`/`false` — toggles work-specific settings |

These values are saved to `~/.config/chezmoi/chezmoi.toml` and reused on subsequent runs.

### Daily usage

```bash
chezmoi update          # Pull latest from GitHub and apply
chezmoi diff            # Preview what would change before applying
chezmoi apply           # Apply without pulling (use local source)
chezmoi edit ~/.zshrc   # Edit a managed file in the source directory
chezmoi add ~/.ssh/config  # Start managing a new file
```

### Editing dotfiles

Edit files in the chezmoi source directory, not the target files directly:

```bash
chezmoi cd                     # Open a shell in the source directory
# ... edit files ...
chezmoi apply                  # Apply changes to $HOME
chezmoi diff                   # Or preview first
```

After editing, commit and push from the source directory:

```bash
chezmoi cd
git add -A && git commit -m "description of change"
git push
```

### Adding secrets

Secrets are encrypted with [age](https://github.com/FiloSottile/age) before committing:

```bash
chezmoi add --encrypt ~/.config/sensitive-file
```

## Syncing Principles to Project Repos

The shared code principles live in `~/.config/opencode/principles/` and get applied
globally via the global `opencode.json`. For **contributor visibility**, projects should
also carry copies of the relevant principles in their repo.

A `sync-principles` script is installed by chezmoi into `~/.local/bin/`. Run it from
any project root to sync:

```bash
# From a project repo root (e.g., armada)
sync-principles              # interactive — shows diffs, asks before overwriting
sync-principles --force      # overwrite all changed files without asking
sync-principles --dry-run    # preview what would change
```

On Windows (PowerShell):

```powershell
sync-principles.ps1
sync-principles.ps1 -Force
sync-principles.ps1 -DryRun
```

The script copies all `*.md` files from `~/.config/opencode/principles/` into
`docs/principles/` in the current project. Project-specific files (ones that don't
exist in the global source) are never touched.

After syncing, reference the principles in the project's `opencode.json`:

```json
{
  "instructions": [
    "docs/principles/universal.md",
    "docs/principles/typescript.md",
    "docs/principles/frontend.md",
    "docs/principles/project-specific.md"
  ]
}
```

### Available principle layers

| File              | When to use                              |
|-------------------|------------------------------------------|
| `universal.md`    | Always — applies to every project        |
| `typescript.md`   | TypeScript/JavaScript projects           |
| `rust.md`         | Rust projects                            |
| `frontend.md`     | Frontend/UI projects                     |
| `backend.md`      | Backend/API projects                     |

Projects should also create their own `docs/principles/<project>.md` for project-specific
rules (e.g., design token conventions, framework constraints).

## Structure

- `dot_*` — Files mapped to `$HOME` via chezmoi naming (`dot_` becomes `.`)
- `dot_config/opencode/` — OpenCode agents, principles, and global config
- `dot_config/opencode/agents/` — Personal agent prompts (not shared with project contributors)
- `dot_config/opencode/principles/` — Shared code principles (copied into project repos)
- `dot_local/bin/` — CLI scripts deployed to `~/.local/bin/` (sync-principles)
- `packages/` — Declarative package lists for Arch Linux and Windows
- `.chezmoiscripts/` — Auto-run scripts for package installation on apply
- `.chezmoiexternal.toml` — External dependencies (LazyVim, oh-my-zsh)
- `.chezmoi.toml.tmpl` — Config template (prompts for name/email/is_work)

## What's managed

- **Shell**: zsh + oh-my-zsh (Linux), PowerShell (Windows), Starship prompt (both)
- **Terminal**: tmux (Linux), Windows Terminal (Windows)
- **AI tools**: OpenCode agents/prompts/principles, GitHub Copilot instructions
- **Git**: Global gitconfig, gitignore, delta diff viewer
- **Dev tools**: mise, LazyVim, VS Code, EditorConfig, npm
- **CLI**: ripgrep, bat, lazygit, fzf
- **Packages**: pacman (Arch), winget (Windows)
- **SSH**: Config (no keys — those stay local)
