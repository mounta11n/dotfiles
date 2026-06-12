# ———————————————————————————————
#  integrations.zsh — Tool-Init
# ———————————————————————————————

# LS_COLORS via vivid
export LS_COLORS="$(vivid generate nord)"

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# mise (dev tools version manager)
eval "$(/Users/yazan/.local/bin/mise activate zsh)"
