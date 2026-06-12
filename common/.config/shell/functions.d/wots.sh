# ———————————————————————————————
#  wots — "stow" rückwärts
#  Backup → Repo → Symlink → Git
# ———————————————————————————————

wots() {
    local src="$1"
    local target="$2"
    local dotfiles_dir="${DOTFILES_DIR:-$HOME/dotfiles}"
    local backup_dir="$dotfiles_dir/.backup/$(date +%Y%m%d_%H%M%S)"

    # ── Hilfe ──
    if [[ -z "$src" || "$src" == "-h" || "$src" == "--help" ]]; then
        cat <<'EOF'
Usage: wots <pfad> [target]

  pfad    Datei oder Ordner, die ins Dotfiles-Repo überführt werden sollen
  target  Stow-Package (z.B. common, macos, linux, agents)
          Fehlt das Target, wird interaktiv gefragt.

Beispiele:
  wots ~/.config/ghostty/config macos
  wots ~/.vimrc common
  wots ~/.config/btop linux
EOF
        return 0
    fi

    # ── Quelle auflösen ──
    if [[ ! -e "$src" ]]; then
        # Versuche relativ zu $HOME
        src="$HOME/$src"
        if [[ ! -e "$src" ]]; then
            echo "Fehler: '$1' nicht gefunden."
            return 1
        fi
    fi
    # Absoluten Pfad ermitteln
    src="$(cd "$(dirname "$src")" && pwd)/$(basename "$src")"

    # ── Relativer Pfad zu $HOME ──
    local rel_path="${src#$HOME/}"
    if [[ "$rel_path" == "$src" ]]; then
        echo "Fehler: '$src' liegt nicht unter \$HOME."
        return 1
    fi

    # ── Ziel-Paket ermitteln ──
    local packages=()
    for d in "$dotfiles_dir"/*/; do
        local name
        name=$(basename "$d")
        [[ "$name" == ".git" || "$name" == ".backup" ]] && continue
        [[ -d "$d" ]] && packages+=("$name")
    done

    if [[ -z "$target" ]]; then
        echo "Kein Target angegeben. Verfügbare Packages:"
        local i=1
        for p in "${packages[@]}"; do
            echo "  $i) $p"
            ((i++))
        done
        echo -n "Auswahl (Nummer oder Name): "
        read -r choice
        if [[ "$choice" =~ ^[0-9]+$ ]]; then
            if (( choice < 1 || choice > ${#packages[@]} )); then
                echo "Ungültige Auswahl."
                return 1
            fi
            target="${packages[$choice]}"
        else
            target="$choice"
        fi
    fi

    # ── Target validieren ──
    local valid=0
    for p in "${packages[@]}"; do
        [[ "$p" == "$target" ]] && valid=1 && break
    done
    if (( valid == 0 )); then
        echo "Fehler: '$target' ist kein gültiges Package unter $dotfiles_dir"
        return 1
    fi

    local dest_dir="$dotfiles_dir/$target/$(dirname "$rel_path")"
    local dest="$dest_dir/$(basename "$rel_path")"

    echo "Quelle:    $src"
    echo "Relativ:   ~/$rel_path"
    echo "Target:    $target"
    echo "Ziel:      $dest"
    echo -n "Fortfahren? [j/N] "
    read -r confirm
    [[ "$confirm" != "j" && "$confirm" != "J" ]] && echo "Abgebrochen." && return 0

    # ── Backup ──
    mkdir -p "$backup_dir"
    local backup_path="$backup_dir/$rel_path"
    mkdir -p "$(dirname "$backup_path")"
    cp -a "$src" "$backup_path"
    echo "Backup:    $backup_path"

    # ── Verschieben ins Repo ──
    mkdir -p "$dest_dir"
    # Falls Ziel schon existiert (z.B. beim Update), Backup bevor Überschreiben
    if [[ -e "$dest" ]]; then
        mv "$dest" "$dest.bak.$(date +%s)"
    fi
    mv "$src" "$dest"
    echo "Verschoben: $dest"

    # ── Symlink erstellen ──
    ln -s "$dest" "$src"
    echo "Symlink:   $src -> $dest"

    # ── Git Workflow ──
    echo "Git: pull → add → commit → push ..."
    (
        cd "$dotfiles_dir" || return 1
        git pull --rebase
        git add "$dest"
        # Auch neue leere Verzeichnisse tracken (falls nötig .gitkeep)
        git status --short
        echo -n "Commit-Nachricht [wots: add $rel_path to $target]: "
        read -r msg
        [[ -z "$msg" ]] && msg="wots: add $rel_path to $target"
        git commit -m "$msg"
        git push
    )

    echo "Fertig. 🎉"
}
