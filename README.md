# dotfiles

Public dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Quick Start (Full Bootstrap)

On a fresh system, run the install script:

```bash
curl -fsSL https://raw.githubusercontent.com/mounta11n/dotfiles/main/install.sh | bash
```

This will automatically detect your OS and:

1. Install dependencies (`zsh`, `git`, `curl`, `age`)
2. Install Oh My Zsh
3. Install [mise](https://mise.jdx.dev/)
4. Install chezmoi and apply these dotfiles
5. Run `mise install` and `mise run bootstrap:agent-clis`

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

## Encrypted Files

Sensitive files are encrypted with [age](https://github.com/FiloSottile/age).
To decrypt them, place your age identity at the expected location
(usually `~/.config/age/key.txt` or as configured in `~/.config/chezmoi/chezmoi.toml`).

## Supported Platforms

| OS | Package Manager |
|---|---|
| macOS (Darwin) | Homebrew |
| Debian / Ubuntu | apt |
| Alpine Linux | apk |

## What's Inside

- **zsh** – `.zshrc`, aliases, functions, completions
- **tmux** – `.tmux.conf`
- **vim** – `.vimrc`
- **git** – `.gitconfig`
- **mise** – tool versions & bootstrap tasks
- **Secrets** – encrypted vault & private configs (age)
