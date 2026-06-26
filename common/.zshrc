# ———————————————————————
#  .zshrc — Loader
# ———————————————————————

setopt SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY HIST_FIND_NO_DUPS

# Module laden
source "$HOME/.config/shell/path.sh"
source "$HOME/.config/shell/env.sh"
source "$HOME/.config/shell/os.zsh"
source "$HOME/.config/shell/theme.zsh"

# Aliases & Functions
source "$SHELL_CONFIG_DIR/aliases.d/aliases.sh"
source "$SHELL_CONFIG_DIR/aliases.d/aliases-brew.sh"
source "$SHELL_CONFIG_DIR/aliases.d/aliases-containers.sh"
source "$SHELL_CONFIG_DIR/aliases.d/aliases-ls-lsd.sh"
source "$SHELL_CONFIG_DIR/aliases.d/aliases-sudos.sh"
source "$SHELL_CONFIG_DIR/aliases.d/aliases-uv.sh"
source "$SHELL_CONFIG_DIR/functions.sh"

# Completions
source "$HOME/.config/shell/completions.zsh"

# Integrations
source "$HOME/.config/shell/integrations.zsh"

# Secrets (verschlüsselt via dotsec/age im Repo)
[ -f "$HOME/.config/shell/secrets.sh" ] && source "$HOME/.config/shell/secrets.sh"

# Geräte-/situationsspezifische lokale Configs (nicht im Repo)
for _local_env in "$SHELL_CONFIG_DIR"/env.*.local(N); do
    source "$_local_env"
done
unset _local_env

# Gerätespezifisch (nicht im Repo)
[ -f "$HOME/.device.sh" ] && source "$HOME/.device.sh"

# Externe Tools
[ -f "$HOME/.lrc/env" ] && source "$HOME/.lrc/env"

# kimi-code
export PATH="/Users/yazan/.kimi-code/bin:$PATH"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"
