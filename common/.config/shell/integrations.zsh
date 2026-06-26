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
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi
