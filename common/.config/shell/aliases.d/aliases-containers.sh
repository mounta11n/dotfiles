
# ———[ container ]————————
alias cup='container-compose up -d'
alias cdown='container-compose down'

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
