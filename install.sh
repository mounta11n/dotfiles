#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Bootstrap script for mounta11n/dotfiles
# Supports: Debian/Ubuntu, Alpine Linux, macOS (Darwin)
# ---------------------------------------------------------------------------

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

info()  { printf "${BLUE}[INFO]${NC}  %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${NC}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${NC}  %s\n" "$*"; }
error() { printf "${RED}[ERROR]${NC} %s\n" "$*"; exit 1; }
step()  { printf "\n${CYAN}▶ %s${NC}\n" "$*"; }

# ---------------------------------------------------------------------------
# Parse optional flags
# ---------------------------------------------------------------------------
INSTALL_AGENT_TOOLS=false
INSTALL_ML_TOOLS=false
INSTALL_HARDWARE_TOOLS=false
INSTALL_MISC_TOOLS=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent-tools)    INSTALL_AGENT_TOOLS=true; shift ;;
    --ml-tools)       INSTALL_ML_TOOLS=true; shift ;;
    --hardware-tools) INSTALL_HARDWARE_TOOLS=true; shift ;;
    --misc-tools)     INSTALL_MISC_TOOLS=true; shift ;;
    -h|--help)
      cat <<'HELP'
Usage: install.sh [OPTIONS]

Bootstrap mounta11n/dotfiles on a fresh system.

Options:
  --agent-tools     Include AI agent CLIs (aichat, claude, copilot, crush,
                    gemini-cli, opencode, pi)
  --ml-tools        Include ML / local LLM tools (micromamba, llmfit, llama.cpp)
  --hardware-tools  Include hardware tools (arduino-cli)
  --misc-tools      Include media & misc tools (astro, cowsay, imagemagick,
                    mermaid-ascii, oha, typst, vhs, yt-dlp)
  -h, --help        Show this help message

Examples:
  # Default (core tools only)
  curl -fsSL https://raw.githubusercontent.com/mounta11n/dotfiles/main/install.sh | bash

  # With optional tool groups
  curl -fsSL ... | bash -s -- --agent-tools --misc-tools

  # Everything
  curl -fsSL ... | bash -s -- --agent-tools --ml-tools --hardware-tools --misc-tools
HELP
      exit 0
      ;;
    *)
      error "Unknown option: $1 (use --help for usage)"
      ;;
  esac
done

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
step "Detected OS: $OS"
sleep 1

# ---------------------------------------------------------------------------
# 1. Install OS-specific dependencies (age, curl, git, zsh)
# ---------------------------------------------------------------------------
step "Installing core system dependencies..."
sleep 1

case "$OS" in
  alpine)
    info "Installing with apk..."
    apk add --no-cache zsh git curl age
    ;;
  debian)
    info "Installing with apt..."
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -qq
    apt-get install -y -qq zsh git curl age
    ;;
  darwin)
    info "Checking for Homebrew..."
    if ! command -v brew &>/dev/null; then
      info "Homebrew not found. Installing now..."
      sleep 1
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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

ok "Core dependencies installed (age, curl, git, zsh)"
sleep 1

# ---------------------------------------------------------------------------
# 2. Switch default shell to zsh
# ---------------------------------------------------------------------------
step "Switching default shell to zsh..."
sleep 1

ZSH_PATH="$(command -v zsh)"
if [ -z "$ZSH_PATH" ]; then
  error "zsh binary not found after installation"
fi

if [ "$SHELL" = "$ZSH_PATH" ]; then
  ok "Default shell is already zsh"
else
  info "Running: chsh --shell $ZSH_PATH"
  info "You may be asked for your password..."
  sleep 1
  if ! chsh --shell "$ZSH_PATH" 2>/dev/null; then
    warn "Could not change default shell automatically."
    warn "Please run manually after this script finishes:"
    warn "  chsh --shell $ZSH_PATH"
  else
    ok "Default shell switched to zsh"
  fi
fi
sleep 1

# ---------------------------------------------------------------------------
# 3. Install Oh My Zsh
# ---------------------------------------------------------------------------
step "Setting up Oh My Zsh..."
sleep 1

if [ -d "$HOME/.oh-my-zsh" ]; then
  ok "Oh My Zsh already installed"
else
  info "Installing Oh My Zsh (unattended mode)..."
  sleep 1
  if [ -t 0 ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
  ok "Oh My Zsh installed"
fi
sleep 1

# ---------------------------------------------------------------------------
# 4. Install mise (zsh-aware)
# ---------------------------------------------------------------------------
step "Installing mise (with zsh activation)..."
sleep 1

if command -v mise &>/dev/null; then
  ok "mise already installed"
else
  info "Downloading and installing mise..."
  sleep 1
  curl https://mise.run/zsh | sh
  ok "mise installed"
fi

# Ensure shims are available in this session
export PATH="$HOME/.local/bin:$PATH"

# Activate mise for the current shell session
if [ -x "$HOME/.local/bin/mise" ]; then
  info "Activating mise in the current session..."
  sleep 1
  eval "$("$HOME/.local/bin/mise" activate bash)"
  ok "mise is now active"
else
  error "mise binary not found at ~/.local/bin/mise"
fi
sleep 1

# ---------------------------------------------------------------------------
# 5. Prepare chezmoi configuration BEFORE init
# ---------------------------------------------------------------------------
step "Preparing chezmoi configuration..."
sleep 1

CHEZMOI_CONFIG_DIR="$HOME/.config/chezmoi"
mkdir -p "$CHEZMOI_CONFIG_DIR"
mkdir -p "$CHEZMOI_CONFIG_DIR/age"

if [ -f "$CHEZMOI_CONFIG_DIR/chezmoi.toml" ]; then
  warn "chezmoi.toml already exists — skipping data variables setup"
  warn "If you want to change options, edit $CHEZMOI_CONFIG_DIR/chezmoi.toml manually"
else
  cat > "$CHEZMOI_CONFIG_DIR/chezmoi.toml" <<EOF
[data]
install_agent_tools = ${INSTALL_AGENT_TOOLS}
install_ml_tools = ${INSTALL_ML_TOOLS}
install_hardware_tools = ${INSTALL_HARDWARE_TOOLS}
install_misc_tools = ${INSTALL_MISC_TOOLS}
EOF
  ok "Created chezmoi.toml with data variables:"
  echo "  install_agent_tools    = ${INSTALL_AGENT_TOOLS}"
  echo "  install_ml_tools       = ${INSTALL_ML_TOOLS}"
  echo "  install_hardware_tools = ${INSTALL_HARDWARE_TOOLS}"
  echo "  install_misc_tools     = ${INSTALL_MISC_TOOLS}"
fi
sleep 1

# ---------------------------------------------------------------------------
# 6. Install chezmoi via mise
# ---------------------------------------------------------------------------
step "Installing chezmoi via mise..."
sleep 1

info "Running: mise use -g chezmoi"
mise use -g chezmoi
ok "chezmoi installed via mise"
sleep 1

# ---------------------------------------------------------------------------
# 7. age-key setup pause (CRITICAL)
# ---------------------------------------------------------------------------
step " age key setup — please read carefully "
sleep 1

info "Some dotfiles are encrypted with age."
info "chezmoi needs your age identity to decrypt them."
echo ""
echo "${YELLOW}────────────────────────────────────────────────────────────${NC}"
echo "  Age key expected at:  ~/.config/chezmoi/age/key.txt"
echo "  Or configure another path in ~/.config/chezmoi/chezmoi.toml"
echo "${YELLOW}────────────────────────────────────────────────────────────${NC}"
echo ""
sleep 2

if [ -f "$CHEZMOI_CONFIG_DIR/age/key.txt" ]; then
  ok "Age key already present at ~/.config/chezmoi/age/key.txt"
else
  echo "You have two options:"
  echo ""
  echo "  ${CYAN}1) SCP from another machine${NC}"
  echo "     scp ~/.config/chezmoi/age/key.txt"
  echo "        ${USER}@$(hostname -I 2>/dev/null | awk '{print $1}' || echo '<host>'):~/.config/chezmoi/age/key.txt"
  echo ""
  echo "  ${CYAN}2) Paste the key directly here${NC}"
  echo ""
  sleep 2

  if [ -t 0 ]; then
    # Interactive — ask the user
    while true; do
      read -r -p "Did you copy the key via SCP, or do you want to paste it now? [scp/paste/skip] " choice
      case "$choice" in
        scp)
          read -r -p "Press Enter once the key is in place..."
          if [ -f "$CHEZMOI_CONFIG_DIR/age/key.txt" ]; then
            ok "Age key detected."
          else
            warn "Key not found at expected path. Continuing anyway..."
          fi
          break
          ;;
        paste)
          info "Paste your age secret key below and press Enter when done:"
          info "(input is hidden for security)"
          read -r -s age_key
          echo ""
          if [ -n "$age_key" ]; then
            printf '%s\n' "$age_key" > "$CHEZMOI_CONFIG_DIR/age/key.txt"
            chmod 600 "$CHEZMOI_CONFIG_DIR/age/key.txt"
            ok "Age key saved."
          else
            warn "Empty key provided. Continuing without key..."
          fi
          break
          ;;
        skip)
          warn "Skipping age key setup. Encrypted files will fail to decrypt."
          info "You can re-run: chezmoi apply"
          info "after placing the key at ~/.config/chezmoi/age/key.txt"
          break
          ;;
        *)
          warn "Please answer: scp, paste, or skip"
          ;;
      esac
    done
  else
    # Non-interactive — just warn and continue
    warn "Non-interactive session detected."
    warn "Please copy your age key to ~/.config/chezmoi/age/key.txt"
    warn "and re-run: chezmoi apply"
    sleep 2
  fi
fi
sleep 1

# ---------------------------------------------------------------------------
# 8. Apply dotfiles with chezmoi
# ---------------------------------------------------------------------------
step "Applying dotfiles with chezmoi..."
sleep 1

info "Running: chezmoi init --apply mounta11n"
chezmoi init --apply mounta11n
ok "Dotfiles applied successfully"
sleep 1

# ---------------------------------------------------------------------------
# 9. Post-setup: install mise-managed tools
# ---------------------------------------------------------------------------
step "Installing all mise-managed tools..."
sleep 1

info "This may take a while on first run. Grab a coffee ☕"
sleep 1
mise install
ok "All mise tools installed"
sleep 1

# ---------------------------------------------------------------------------
# 10. Run bootstrap tasks
# ---------------------------------------------------------------------------
step "Running bootstrap tasks..."
sleep 1

if [ "$INSTALL_AGENT_TOOLS" = true ]; then
  info "Running bootstrap:agent-tools..."
  mise run bootstrap:agent-tools
  ok "Agent tools bootstrapped"
  sleep 1
fi

if [ "$INSTALL_ML_TOOLS" = true ]; then
  info "Running bootstrap:ml-tools..."
  mise run bootstrap:ml-tools
  ok "ML tools bootstrapped"
  sleep 1
fi

if [ "$INSTALL_HARDWARE_TOOLS" = true ]; then
  info "Running bootstrap:hardware-tools..."
  mise run bootstrap:hardware-tools
  ok "Hardware tools bootstrapped"
  sleep 1
fi

if [ "$INSTALL_MISC_TOOLS" = true ]; then
  info "Running bootstrap:misc-tools..."
  mise run bootstrap:misc-tools
  ok "Misc tools bootstrapped"
  sleep 1
fi

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo ""
echo "${GREEN}════════════════════════════════════════════════════════════${NC}"
echo "${GREEN}  Setup complete! 🎉${NC}"
echo "${GREEN}════════════════════════════════════════════════════════════${NC}"
echo ""
info "Next steps:"
echo "  • Restart your shell or run: source ~/.zshrc"
echo "  • Run 'chezmoi doctor' to verify everything is working."
echo ""
info "Optional tool groups enabled this run:"
[ "$INSTALL_AGENT_TOOLS"    = true ] && echo "    ✓ --agent-tools"
[ "$INSTALL_ML_TOOLS"       = true ] && echo "    ✓ --ml-tools"
[ "$INSTALL_HARDWARE_TOOLS" = true ] && echo "    ✓ --hardware-tools"
[ "$INSTALL_MISC_TOOLS"     = true ] && echo "    ✓ --misc-tools"
echo ""
