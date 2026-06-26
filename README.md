# dotfiles

> Verwaltet mit [GNU Stow](https://www.gnu.org/software/stow/) — Symlink-basiert, kein Magic.

## 🚀 Quick Start

```bash
# 1. Repo klonen
git clone https://github.com/mounta11n/dotfiles.git ~/dotfiles

# 2. Pakete stowen (Symlinks legen)
cd ~/dotfiles

#    Linux-Server:
stow --restow common linux

#    macOS:
stow --restow common macos

# 3. Shell wechseln (falls nicht schon zsh)
chsh -s $(which zsh)
```

---

## ⚠️ Was stow NICHT macht

Stow legt **ausschließlich Symlinks** von `~/dotfiles/` nach `~/`. Es installiert keine Pakete, ändert keine Systemeinstellungen und führt keine Skripte aus. Alles Folgende musst du **manuell oder via Bootstrap-Skript** erledigen.

---

## ✅ Checkliste nach git clone

### 🔧 System & Shell

| Schritt | Befehl / Hinweis |
|---|---|
| **zsh** installieren | `apt install zsh` (Debian) / `brew install zsh` (macOS) |
| **zsh als Default-Shell** | `chsh -s $(which zsh)` |
| **Oh-My-Zsh** | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |
| **Starship Prompt** | `curl -sS https://starship.rs/install.sh \| sh` |
| **mise** (Version Manager) | `curl https://mise.run \| sh` |
| **zoxide** (smart cd) | `apt install zoxide` / `brew install zoxide` |
| **fzf** (fuzzy finder) | `apt install fzf` / `brew install fzf` |
| **vivid** (LS_COLORS) | `cargo install vivid` oder `apt install vivid` |
| **age** (Verschlüsselung) | `apt install age` / `brew install age` |
| **dotsec Setup** | `dotsec setup` → age-Key erzeugen und extern sichern |

### 🛠 CLI-Tools

| Tool | Zweck | Installation |
|---|---|---|
| `bat` | cat-Ersatz | `apt install bat` / `brew install bat` |
| `lsd` / `eza` | ls-Ersatz | `apt install lsd` / `cargo install eza` |
| `btop` | Prozess-Monitor | `apt install btop` / `brew install btop` |
| `tmux` | Terminal-Multiplexer | `apt install tmux` / `brew install tmux` |
| `nvim` / `vim` | Editor | `apt install neovim` / `brew install neovim` |
| `yazi` | TUI-Dateimanager | `cargo install yazi-fm` |
| `micro` | Einfacher Editor | `apt install micro` / `brew install micro` |
| `fastfetch` | System-Info | `apt install fastfetch` / `brew install fastfetch` |
| `ripgrep` | grep-Ersatz | `apt install ripgrep` / `brew install ripgrep` |
| `fd` | find-Ersatz | `apt install fd-find` / `brew install fd` |

### 🎮 Nice-to-Have

| Tool | Zweck |
|---|---|
| `gh` | GitHub CLI |
| `glab` | GitLab CLI |
| `uv` | Python Package Manager |
| `chafa`, `jp2a` | Bildbetrachter im Terminal |
| `lolcrab` | 🦀 Spaß |
| `gitui` | Git-TUI |
| `docker` / `podman` | Container |
| `ntfy` | Benachrichtigungen |
| `chezmoi` | Alternative Dotfile-Verwaltung |

---

## 🤖 Bootstrap (optional)

```bash
# Automatisierte Installation für Debian/Ubuntu:
bash ~/dotfiles/bootstrap.sh
```

Das Skript installiert alle essentiellen Pakete, wechselt zu zsh und führt stow aus.

---

## 🔐 Secrets (dotsec)

Secrets werden mit [age](https://github.com/FiloSottile/age) verschlüsselt im Repo abgelegt:

```bash
# Einmalig pro Gerät:
dotsec setup       # age-Schlüsselpaar erzeugen
                   # → Identity extern sichern! (1Password, USB-Stick...)

# Secrets bearbeiten:
vim ~/.config/shell/secrets.sh
dotsec lock        # → verschlüsselt + committed + pushed

# Auf neuem Gerät:
git pull
dotsec unlock      # → entschlüsselt secrets.sh
```

---

## 📁 Struktur

```
dotfiles/
├── common/          # OS-übergreifend (zsh, tmux, mise, nvim, yazi...)
│   └── .config/
│       ├── shell/       # Shell-Module (aliases, functions, env, theme)
│       ├── tmux/        # tmux.conf + session-status.sh
│       ├── mise/        # mise config.toml
│       ├── nvim/        # Neovim-Config
│       ├── yazi/        # Yazi-Config + Plugins
│       ├── starship.toml
│       ├── ghostty/     # Ghostty-Terminal
│       └── ...
├── macos/           # Nur macOS (zed, hammerspoon, ...)
│   └── .config/
├── linux/           # Nur Linux (geany, ...)
│   └── .config/
└── bootstrap.sh     # Setup-Skript für frische Maschinen
```

---

## 🔄 Workflow: Config ändern

```bash
# Datei direkt im Repo bearbeiten (Symlink zeigt dorthin)
vim ~/dotfiles/common/.zshrc

# Änderungen testen
source ~/.zshrc

# Committen & pushen
cd ~/dotfiles
git add -A
git commit -m "zshrc: neue aliases"
git push
```

Oder mit `wots` eine neue Datei ins stow-System aufnehmen:

```bash
wots ~/.config/mein-tool/config.conf linux
```

---

## 🐛 Troubleshooting

| Problem | Lösung |
|---|---|
| Shell sieht generisch aus | `echo $SHELL` → wahrscheinlich bash. `chsh -s $(which zsh)` |
| „command not found: starship“ | Starship nachinstallieren (siehe Checkliste) |
| Konflikte beim stowen | `stow --restow --adopt common linux` |
| `dotsec: command not found` | `source ~/.zshrc` (Funktion wird erst nach Shell-Neustart geladen) |
| Oh-My-Zsh fehlt | Theme lädt nicht → `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |
