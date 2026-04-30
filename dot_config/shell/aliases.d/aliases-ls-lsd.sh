
# ——— lsd —————————————————————————————
alias l='lsd --oneline --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --sort=version --ignore-glob=.DS_Store'

alias ll='lsd --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --long --permission=rwx --size=default --date=relative --sort=version --git --no-symlink --blocks=permission,user,size,date,git,name --ignore-glob=.DS_Store'

alias LL='lsd --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --long --permission=rwx --size=default --total-size --date=relative --sort=size --git --no-symlink --blocks=permission,user,size,date,git,name --ignore-glob=.DS_Store'

alias ll-ext='lsd --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --long --permission=rwx --size=default --date=relative --sort=extension --git --no-symlink --blocks=permission,user,size,date,git,name --ignore-glob=.DS_Store'

alias ll-size='lsd --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --long --permission=rwx --size=default --date=relative --sort=size --git --no-symlink --blocks=permission,user,size,date,git,name --ignore-glob=.DS_Store'

alias ll-time='lsd --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --long --permission=rwx --size=default --date=relative --sort=time --git --no-symlink --blocks=permission,user,size,date,git,name --ignore-glob=.DS_Store'

alias lll='lsd --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --long --recursive --permission=octal --size=default --date=relative --sort=version --blocks=permission,user,size,date,name'

alias LLL='lsd --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --long --recursive --permission=octal --size=default --date=relative --sort=size --total-size --blocks=permission,user,size,date,name'

alias tt='lsd --almost-all --classify --group-dirs=first --icon-theme=fancy --literal --long  --tree  --ignore-glob=.DS_Store'
