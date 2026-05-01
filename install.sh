#!/bin/bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Bootstrap script for mounta11n/dotfiles
# Supports: Debian/Ubuntu, Alpine Linux, macOS (Darwin)
# ---------------------------------------------------------------------------

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { printf "${BLUE}[INFO]${NC}  %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${NC}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${NC}  %s\n" "$*"; }
error() { printf "${RED}[ERROR]${NC} %s\n" "$*"; exit 1; }

detect_os() {
  case "$(uname -s)" in
    Linux)
      if [ -f /etc/alpine-release ]; then
        echo "alpine"
      elif [ -f /etc/debian_version ]; then
        echo "debian"
      else
        error "Unsupported Linux distribution. Only Debian and Alpine are supported."
      fi
      ;;
    Darwin)
      echo "darwin"
      ;;
    *)
      error "Unsupported OS: $(uname -s)"
      ;;
  esac
}

OS=$(detect_os)
info "Detected OS: $OS"

# ---------------------------------------------------------------------------
# 1. Install OS-specific dependencies
# ---------------------------------------------------------------------------
case "$OS" in
  alpine)
    info "Installing dependencies with apk..."
    apk add --no-cache zsh git curl age
    ;;
  debian)
    info "Installing dependencies with apt..."
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -qq
    apt-get install -y -qq zsh git curl age
    ;;
  darwin)
    info "Checking for Homebrew..."
    if ! command -v brew &>/dev/null; then
      info "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      # Add brew to PATH for Apple Silicon and Intel Macs
      if [ -d /opt/homebrew/bin ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [ -d /usr/local/bin ]; then
        eval "$(/usr/local/bin/brew shellenv 2>/dev/null || true)"
      fi
    else
      ok "Homebrew already installed"
    fi
    info "Installing packages with brew..."
    brew install git curl age
    ;;
esac
ok "Dependencies installed"

# ---------------------------------------------------------------------------
# 2. Install Oh My Zsh
# ---------------------------------------------------------------------------
if [ -d "$HOME/.oh-my-zsh" ]; then
  ok "Oh My Zsh already installed"
else
  info "Installing Oh My Zsh..."
  if [ -t 0 ]; then
    # Interactive session — allow OMZ to ask about the default shell
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    # Non-interactive — unattended mode (e.g. VPS provisioning)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
  ok "Oh My Zsh installed"
fi

# ---------------------------------------------------------------------------
# 3. Install mise
# ---------------------------------------------------------------------------
if command -v mise &>/dev/null; then
  ok "mise already installed"
else
  info "Installing mise..."
  curl https://mise.run | sh
  ok "mise installed"
fi

# Ensure ~/.local/bin is available in this session
export PATH="$HOME/.local/bin:$PATH"

# ---------------------------------------------------------------------------
# 4. Install chezmoi and apply dotfiles
# ---------------------------------------------------------------------------
info "Installing chezmoi and applying dotfiles..."
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply mounta11n
ok "Dotfiles applied"

# ---------------------------------------------------------------------------
# 5. Post-setup: mise tools & bootstrap
# ---------------------------------------------------------------------------
info "Installing mise-managed tools..."
mise install

info "Running bootstrap:agent-clis..."
mise run bootstrap:agent-clis

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
ok "Setup complete! 🎉"
echo ""
echo "Next steps:"
echo "  • Restart your shell or run: source ~/.zshrc"
echo "  • If this is your first time, set up your age key for encrypted files."
echo "  • Run 'chezmoi doctor' to verify everything is working."
