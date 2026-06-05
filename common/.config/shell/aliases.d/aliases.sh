# ———[ ALIASES ]————————
alias ..='cd .. && l'
alias ...='cd ../.. && l'
alias ....='cd ../../.. && l'
alias btp='btop -p 1 --force-utf'
alias topp='btop -p 1 --force-utf'
alias catt='bat'
alias cl='clear'
alias conda='micromamba'
alias cfa="$EDITOR $HOME/.aliases"
alias cfb="$EDITOR $HOME/.bashrc"
alias cfv="$EDITOR $HOME/.vault"
alias cfz="$EDITOR $HOME/.zshrc"
alias chaf='chafa -f symbols --symbols ascii -c 256'
alias chaf-0='chafa -f symbols --symbols ascii -c none'
alias chaf-2='chafa -f symbols --symbols ascii -c 2'
alias chaf-16='chafa -f symbols --symbols ascii -c 16'
alias echopath='echo $PATH | tr ":" "\n"'
alias ffetch="fastfetch --config $HOME/.config/fastfetch/presets/examples/10.jsonc"
alias freecache='echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias fzfbat="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias grep='grep --color=auto --ignore-case --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
alias glep='ls --color=auto -1AF | grep'
alias gllep='ls --color=auto -FAhl | grep'
alias ino='arduino-cli'
alias ip='ip --color=auto'
alias jpa='jp2a --border --colors --fill --width=100'
alias lns='ln -s'
alias l='ls --color=auto -1AF'
alias ll='ls --color=auto -aFhl'
alias lol='lolcrab'
alias loll='curl -s https://whatthecommit.com/index.txt && echo'
alias mic="micro"
alias modx='chmod +x'
alias mod-x='chmod -x'
alias ns='netstat'
alias nv='nvim'
alias ossl='openssl rand -base64'
alias ports='netstat -atuln'
alias pwgn='pwgen -c -n -B -C -1 -C'
alias src='source ~/.zshrc'
alias rcp='rsync --archive --verbose --recursive --human-readable --partial --progress --update --ignore-existing'
alias tb='nc termbin.com 9999'
alias todosh='todo.sh add'
alias ttt='tree -a -d -L 3'
alias tt='tree -a -L 2'
alias t='tree -a -L 1'
alias tea='| tee -a ~/.logs/tea.log'
alias v='vim'
alias venva='python -m venv ./.venv && source .venv/bin/activate'
alias ww='which'
alias xc='open -a Xcode'
alias xtr='dtrx'
alias xx='exit'
alias yy='yazi'
alias zz='zed'

# ———[ git ]————————
alias g='git'
alias gcl='git clone'
alias gg='gitui'
alias glc='git lfs clone'
alias gull='git pull'
alias gush='git push'
alias wasgit='git status'
alias yolo='git add . && git commit -m "$(curl -s https://whatthecommit.com/index.txt)"'

# ———[ tmux ]————————
alias tmx='tmux'
alias tma='tmux attach'
alias tml='tmux ls'
alias tmn='tmux new -s'
alias tms='tmux new -s -2'

# ———[ Agents ]————————
alias coder='little-coder'
alias di='dirac'
alias oc='opencode'

# ———[ ntfy ]————————
alias an='ntfy pub'
alias about-me-suse='ntfy pub about-suse'
alias an-alma-inbox='ntfy pub an-alma-inbox'
alias an-alma-direkt='ntfy pub an-alma-direkt'
alias waslos='ntfy sub'
alias waslos-alma='ntfy sub about-alma'

# ———[ typst ]————————
alias tyc='typst compile'
alias tyi='typst init'

# ———[ preserve xattrs ]————————
#alias cp='cp --preserve=all'
alias cp='cp -i'
alias curl='curl --xattr'
alias rsync='rsync -X'
alias tar='tar --xattrs'
alias wget='wget -c --xattr'
alias yt-dlp='yt-dlp --xattrs'

# ———[ Else ]————————
alias easy='graph-easy'
alias ptr='pter ~/Notes/todo/todo.txt'
alias splay='soco move play_file'
alias zj='zellij'
alias cly='y-cli'
alias codi='codium'
alias aria='aria2c -UWget'
alias fabric='fabric-ai'
alias chrome-debug='/Applications//Google\ Chrome\ Dev.app/Contents/MacOS/Google\ Chrome\ Dev --remote-debugging-port=9222 --user-data-dir=/tmp/chrome-debug --no-first-run'
