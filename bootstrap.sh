#!/usr/bin/env bash
# ———————————————————————————————
#  bootstrap.sh — Dotfiles Setup
#  Ziel: Debian/Ubuntu-Server
# ———————————————————————————————
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# ——— Farben ———
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info()  { echo -e "${GREEN}→${NC} $*"; }
warn()  { echo -e "${YELLOW}⚠${NC}  $*"; }
err()   { echo -e "${RED}✗${NC}  $*"; }

# ——— OS-Check ———
if [[ "$(uname -s)" == "Darwin" ]]; then
    warn "macOS erkannt — dieses Skript ist für Debian/Ubuntu gedacht."
    warn "Bitte lies die README.md für macOS-Schritte."
    exit 1
fi

info "Dotfiles Bootstrap — $(date)"

# ——— Grundpakete ———
ESSENTIALS="zsh git curl wget stow age"
RECOMMENDED="tmux neovim bat btop fzf zoxide lsd ripgrep fd-find fastfetch micro vivid"

info "Installiere essentielle Pakete..."
apt-get update -qq
apt-get install -y -qq $ESSENTIALS $RECOMMENDED

# ——— fd → fdfind (Debian) ———
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    ln -sf "$(which fdfind)" /usr/local/bin/fd
fi

# ——— Oh-My-Zsh ———
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    info "Installiere Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    info "Oh-My-Zsh bereits vorhanden."
fi

# ——— Starship ———
if ! command -v starship >/dev/null 2>&1; then
    info "Installiere Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    info "Starship bereits vorhanden."
fi

# ——— mise ———
if ! command -v mise >/dev/null 2>&1; then
    info "Installiere mise..."
    curl https://mise.run | sh
    # mise aktivieren (wird von integrations.zsh auch gemacht)
    eval "$($HOME/.local/bin/mise activate bash)"
else
    info "mise bereits vorhanden."
fi

# ——— zoxide (in integrations.zsh via eval) ———
if command -v zoxide >/dev/null 2>&1; then
    info "zoxide: OK"
else
    warn "zoxide nicht gefunden — bitte manuell installieren"
fi

# ——— Default-Shell auf zsh ———
if [[ "$SHELL" != *"zsh"* ]]; then
    info "Wechsle Default-Shell zu zsh..."
    ZSH_PATH="$(which zsh)"
    if ! grep -q "$ZSH_PATH" /etc/shells; then
        echo "$ZSH_PATH" >> /etc/shells
    fi
    chsh -s "$ZSH_PATH" root
else
    info "zsh ist bereits Default-Shell."
fi

# ——— Stow ———
if [[ -d "$DOTFILES_DIR" ]]; then
    info "Führe stow aus..."
    cd "$DOTFILES_DIR"
    git pull --rebase 2>/dev/null || true
    # Oh-My-Zsh legt ein eigenes .zshrc an → entfernen vor stow
    [[ -f "$HOME/.zshrc" ]] && [[ ! -L "$HOME/.zshrc" ]] && rm -f "$HOME/.zshrc"
    stow --restow common linux
    info "Symlinks gesetzt."
else
    warn "dotfiles-Verzeichnis nicht gefunden unter $DOTFILES_DIR"
    warn "Bitte zuerst klonen:"
    warn "  git clone https://github.com/mounta11n/dotfiles.git $DOTFILES_DIR"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Bootstrap abgeschlossen!${NC}"
echo ""
echo "Nächste Schritte:"
echo "  1) Neustart oder 'exec zsh' für die neue Shell"
echo "  2) dotsec setup  → age-Schlüssel einrichten"
echo "  3) dotsec unlock → Secrets entschlüsseln (falls vorhanden)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
