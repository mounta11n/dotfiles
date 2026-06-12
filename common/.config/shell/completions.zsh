# ———————————————————————————————
#  completions.zsh — Completions
# ———————————————————————————————

fpath+=~/.zfunc
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Llama completion (bash compat)
source "$SHELL_CONFIG_DIR/completions.d/llama-completion.bash"

# bun completions
[ -s "$HOME/.oh-my-zsh/completions/_bun" ] && source "$HOME/.oh-my-zsh/completions/_bun"
