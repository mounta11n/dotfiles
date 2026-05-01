# dotfiles

Public dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Quick Start (Full Bootstrap)

On a fresh system, run the install script:

```bash
# Core tools only (recommended for most VPS)
curl -fsSL https://raw.githubusercontent.com/mounta11n/dotfiles/main/install.sh | bash

# With optional tool groups
curl -fsSL https://raw.githubusercontent.com/mounta11n/dotfiles/main/install.sh | bash -s -- --agent-tools --misc-tools

# Everything (local machine with plenty of RAM)
curl -fsSL https://raw.githubusercontent.com/mounta11n/dotfiles/main/install.sh | bash -s -- --agent-tools --ml-tools --hardware-tools --misc-tools
```

Available flags:

| Flag | Tools included |
|------|---------------|
| `--agent-tools` | `aichat`, `claude`, `copilot`, `crush`, `gemini-cli`, `opencode`, `pi` |
| `--ml-tools` | `micromamba`, `llmfit`, `llama.cpp` (heavy — needs RAM/GPU) |
| `--hardware-tools` | `arduino-cli` |
| `--misc-tools` | `astro`, `cowsay`, `imagemagick`, `mermaid-ascii`, `oha`, `typst`, `vhs`, `yt-dlp` |

This will automatically detect your OS and:

1. Install core dependencies (`zsh`, `git`, `curl`, `age`)
2. Switch your default shell to **zsh**
3. Install Oh My Zsh
4. Install [mise](https://mise.jdx.dev/) (with zsh activation)
5. Configure chezmoi with your chosen tool groups
6. Install chezmoi **via mise**
7. Pause for your **age key** setup (encrypted files)
8. Apply dotfiles with `chezmoi init --apply`
9. Run `mise install` and conditional bootstrap tasks

---

## One-Shot Setup (kein lokales Git)

If you only want to **apply** the dotfiles once and do not plan to edit or push changes from this machine:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mounta11n
```

To update later, simply re-run the same command.

## Permanent / Git-Aware Setup

If you want to **track local changes** and push them back to GitHub:

```bash
# 1. Install chezmoi permanently
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

# 2. Initialize (clones into ~/.local/share/chezmoi)
chezmoi init git@github.com:mounta11n/dotfiles.git

# 3. Apply the dotfiles
chezmoi apply

# 4. Work inside the source directory
cd "$(chezmoi source-path)"

# Make changes, then add & push
chezmoi add ~/.zshrc
chezmoi git add .
chezmoi git commit -m "update"
chezmoi git push
```

Pull remote updates:

```bash
chezmoi update
```

---

## Machine-Specific Configuration (`~/.config/chezmoi/chezmoi.toml`)

This file is **NOT tracked** in the dotfiles repository — and that is intentional.
It lives outside the repo because it contains secrets (e.g. your age identity) and
machine-specific preferences that differ between your MacBook, a VPS, and a Raspberry Pi.

### What goes in here?

- **Encryption keys** (age identity paths)
- **Data variables** for conditional templates (see below)
- **Machine-specific settings** (different Git email for work vs. personal, etc.)

### Data variables for optional tools

Some tools in `mise/config.toml` are gated behind template conditions. You control them
via the `[data]` section in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
install_agent_tools    = false   # aichat, claude, copilot, crush, gemini-cli, opencode, pi
install_ml_tools       = false   # micromamba, llmfit, llama.cpp (heavy)
install_hardware_tools = false   # arduino-cli
install_misc_tools     = false   # astro, cowsay, imagemagick, vhs, yt-dlp, ...
```

After changing these values, re-apply the config:

```bash
chezmoi apply ~/.config/mise/config.toml
```

### Example: enabling ML tools on your MacBook

```bash
# Edit your local chezmoi config
chezmoi edit-config

# Add:
# [data]
# install_ml_tools = true

# Re-apply
chezmoi apply ~/.config/mise/config.toml
mise install
mise run bootstrap:ml-tools
```

### Why not track this file?

If `chezmoi.toml` were in the repo, every machine would share the same config.
That would mean:
- Your age secret key path would be public (bad)
- Every VPS would try to install `llama.cpp` even with 1 GB RAM (bad)
- Work Git settings would leak onto personal machines (bad)

Keeping it **local and untracked** is the cleanest pattern for dotfiles.

---

## Encrypted Files

Sensitive files are encrypted with [age](https://github.com/FiloSottile/age).
To decrypt them, place your age identity at the expected location
(usually `~/.config/chezmoi/age/key.txt` or as configured in `~/.config/chezmoi/chezmoi.toml`).

## Supported Platforms

| OS | Package Manager |
|---|---|
| macOS (Darwin) | Homebrew |
| Debian / Ubuntu | apt |
| Alpine Linux | apk |

## What's Inside

- **zsh** — `.zshrc`, aliases, functions, completions
- **tmux** — `.tmux.conf`
- **vim** — `.vimrc`
- **git** — `.gitconfig`
- **mise** — tool versions & bootstrap tasks (with OS & conditional support)
- **Secrets** — encrypted vault & private configs (age)
