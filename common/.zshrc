# ———————————————————————
#  .zshrc — Loader
# ———————————————————————

setopt SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY HIST_FIND_NO_DUPS

# Module laden
source "$HOME/.config/shell/path.zsh"
source "$HOME/.config/shell/env.zsh"
source "$HOME/.config/shell/os.zsh"
source "$HOME/.config/shell/theme.zsh"

# Aliases & Functions
source "$MY_DOT_FILES_DIR/aliases.d/aliases.sh"
source "$MY_DOT_FILES_DIR/aliases.d/aliases-brew.sh"
source "$MY_DOT_FILES_DIR/aliases.d/aliases-containers.sh"
source "$MY_DOT_FILES_DIR/aliases.d/aliases-ls-lsd.sh"
source "$MY_DOT_FILES_DIR/aliases.d/aliases-sudos.sh"
source "$MY_DOT_FILES_DIR/aliases.d/aliases-uv.sh"
source "$MY_DOT_FILES_DIR/functions.sh"

# Completions
source "$HOME/.config/shell/completions.zsh"

# Integrations
source "$HOME/.config/shell/integrations.zsh"

# Secrets (nicht im Repo — nur laden wenn vorhanden)
[ -f "$HOME/.config/shell/secrets.zsh" ] && source "$HOME/.config/shell/secrets.zsh"

# Gerätespezifisch (nicht im Repo)
[ -f "$HOME/.device.sh" ] && source "$HOME/.device.sh"

# Externe Tools
[ -f "$HOME/.lrc/env" ] && source "$HOME/.lrc/env"
