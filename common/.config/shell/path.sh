# ———————————————————————————————
#  path.sh — PATH & Directories
# ———————————————————————————————

path_prepend() {
  [ -d "$1" ] || return
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

# ——— Essential Paths ———
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.bun/bin"
path_prepend "/usr/local/go/bin"
path_prepend "$HOME/.go/bin"
path_prepend "$HOME/.juliaup/bin"
path_prepend "$HOME/.cargo/bin/"
path_prepend "$HOME/.lmstudio/bin"

# ——— Additional Paths ———
export VIBE_HOME="$HOME/.vibe"
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/.go"

# ——— Custom Paths ———
export SHELL_CONFIG_DIR="$HOME/.config/shell"
export MY_LLM_MODELS_DIR="$HOME/models/llm"
export MY_STT_MODELS_DIR="$HOME/models/stt"
export MY_TTS_MODELS_DIR="$HOME/models/tts"

export KIMI_SHARE_DIR="$HOME/.kimi"
