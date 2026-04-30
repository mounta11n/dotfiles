

# ———[ ALIASES ]————————
alias ..='cd .. && l'
alias ...='cd ../.. && l'
alias ....='cd ../../.. && l'
# alias bath='-h | bat'
# alias bath='bat --plain --language=help'
alias btp='btop -p 1 --force-utf'
alias topp='btop -p 1 --force-utf'
alias cat='bat'
alias cl='clear'
alias conda='micromamba'
alias cfa="$EDITOR $HOME/.aliases"
alias cfb="$EDITOR $HOME/.bashrc"
alias cfv="$EDITOR $HOME/.vault"
alias cfz="$EDITOR $HOME/.zshrc"
alias echopath='echo $PATH | tr ":" "\n"'
alias ffetch="fastfetch --config $HOME/.config/fastfetch/presets/examples/10.jsonc"
alias fzfbat="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias glep='ls --color=auto -1AF | grep'
alias gllep='ls --color=auto -FAhl | grep'
alias ino='arduino-cli'
alias ip='ip --color=auto'
alias lns='ln -s'
alias l='ls --color=auto -1AF'
alias ll='ls --color=auto -aFhl'
alias mic="micro"
alias modx='chmod +x'
alias mod-x='chmod -x'
alias nv='nvim'
alias ossl='openssl rand -base64'
alias pwgn='pwgen -c -n -B -C -1 -C'
#alias src='source ~/.bashrc'
alias src='source ~/.zshrc'
alias rcp='rsync --archive --verbose --recursive --human-readable --partial --progress --update --ignore-existing'
alias ttt='tree -a -d -L 3'
alias tt='tree -a -L 2'
alias t='tree -a -L 1'
alias tea='| tee -a ~/.logs/tea.log'
alias v='vim'
alias venva='python -m venv ./.venv && source .venv/bin/activate'
alias ww='which'
alias xc='open -a Xcode'
alias xx='exit'
alias yy='yazi'
alias zz='zed'



# ———[ preserve xattrs ]————————
alias curl='curl --xattr'
alias wget='wget -c --xattr'
alias yt-dlp='yt-dlp --xattrs'
alias tar='tar --xattrs'
alias cp='cp -i'
#alias cp='cp --preserve=all'
alias rsync='rsync -X'



# ———[ git ]————————
alias g='git'
alias gcl='git clone'
alias gg='gitui'
alias glc='git lfs clone'
alias gull='git pull'
alias gush='git push'
alias wasgit='git status'
alias yolo='git add . && git commit -m "$(curl -s https://whatthecommit.com/index.txt)"'



# ———[ typst ]————————
alias tyc='typst compile'
alias tyi='typst init'


# ———[ tmux ]————————
alias tmx='tmux'
alias tma='tmux attach'
alias tml='tmux ls'
alias tmn='tmux new -s'
alias tms='tmux new -s -2'



# ———[ distrobox ]————————
alias dbox='distrobox'
alias dbl='distrobox ls'
alias dbc='distrobox create'
alias dbe='distrobox enter'



# ———[ docker ]————————
alias dockers='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dockies='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"'
alias dcdown='docker-compose down'
alias dcup='docker-compose up -d'
alias dcvol='docker volume ls'
alias dclogs='docker logs'



# ———[ podman ]————————
alias pod='podman'
alias poders='podman ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias pods='podman ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"'
alias pcdown='podman compose down'
alias pcup='podman compose up -d'



# ———[ ntfy ]————————
alias an='ntfy pub'
alias about-me-suse='ntfy pub about-suse'
alias an-alma-inbox='ntfy pub an-alma-inbox'
alias an-alma-direkt='ntfy pub an-alma-direkt'
alias waslos='ntfy sub'
alias waslos-alma='ntfy sub about-alma'



# ———[ Else ]————————
alias easy='graph-easy'
alias freecache='echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias jpa='jp2a --border --colors --fill --width=100'
alias lol='curl -s https://whatthecommit.com/index.txt && echo'
alias ptr='pter ~/Notes/todo/todo.txt'
alias splay='soco move play_file'
#alias todo='/usr/bin/sss-todo -c -d /home/yazan/.config/todo-sh/todo.cfg'
alias todosh='todo.sh'
alias xtr='dtrx'
alias zj='zellij'
alias cly='y-cli'
alias codi='codium'
alias aria='aria2c -UWget'
alias chrome-debug='/Applications//Google\ Chrome\ Dev.app/Contents/MacOS/Google\ Chrome\ Dev --remote-debugging-port=9222 --user-data-dir=/tmp/chrome-debug --no-first-run'
alias fabric='fabric-ai'
alias coder='little-coder'
