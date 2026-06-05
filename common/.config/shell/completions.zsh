# ———————————————————————————————
#  completions.zsh — Completions
# ———————————————————————————————

fpath+=~/.zfunc
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Llama completion (bash compat)
source "$MY_DOT_FILES_DIR/completions.d/llama-completion.bash"
