# ———————————————————————————————
#  theme.zsh — Oh-My-Zsh & Prompt
# ———————————————————————————————

export ZSH="$HOME/.oh-my-zsh"

# nice themes: bira, blinks, bureau, duellj, fino
# ZSH_THEME="bira-plus"
plugins=()

source "$ZSH/oh-my-zsh.sh"
eval "$(starship init zsh)"
