# ———————————————————————————————
#  env.zsh — Environment Variables
# ———————————————————————————————

export EDITOR='nvim'
export ARCHFLAGS="-arch $(uname -m)"

# Homebrew
export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_UPGRADE_GREEDY=false
export HOMEBREW_NO_SORBET_RUNTIME=1
export HOMEBREW_REQUIRE_TAP_TRUST=1

# Hugging Face
export HF_HUB_DISABLE_TELEMETRY=true
export HF_XET_HIGH_PERFORMANCE=true

# npm
export npm_config_userconfig="$HOME/.config/npm/npmrc"

# Kimi
export KIMI_CLI_NO_AUTO_UPDATE="0"
export KIMI_CLI_PASTE_CHAR_THRESHOLD="1000"
export KIMI_CLI_PASTE_LINE_THRESHOLD="15"
