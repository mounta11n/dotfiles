# ———————————————————————————————
#  dotsec — Secrets mit age locken/unlocken
#  Entschlüsselt: ~/.config/shell/secrets.sh
#  Verschlüsselt:  ~/dotfiles/common/.config/shell/secrets.sh.age
# ———————————————————————————————

dotsec() {
    local action="$1"
    local age_key="${AGE_KEY:-$HOME/.config/age/identity.txt}"
    local age_recipient="${AGE_RECIPIENT:-$HOME/.config/age/recipient.txt}"
    local secrets_file="$HOME/.config/shell/secrets.sh"
    local encrypted_file="${DOTFILES_DIR:-$HOME/dotfiles}/common/.config/shell/secrets.sh.age"

    # ── Hilfe ──
    if [[ -z "$action" || "$action" == "-h" || "$action" == "--help" ]]; then
        cat <<'EOF'
Usage: dotsec <lock|unlock|setup|status>

  lock    Verschlüsselt ~/.config/shell/secrets.sh → Repo
  unlock  Entschlüsselt aus dem Repo → ~/.config/shell/secrets.sh
  setup   Erzeugt ein neues age-Schlüsselpaar
  status  Zeigt den aktuellen Zustand an

Umgebungsvariablen (optional):
  AGE_KEY         Pfad zur age-Identity (default: ~/.config/age/identity.txt)
  AGE_RECIPIENT   Pfad zum age-Recipient (default: ~/.config/age/recipient.txt)

Beispiel:
  dotsec setup   # Einmalig auf jedem Gerät
  dotsec lock    # Nach Änderungen an secrets.sh
  dotsec unlock  # Auf einem neuen Gerät nach git pull
EOF
        return 0
    fi

    case "$action" in
        setup)
            if [[ -f "$age_key" ]]; then
                echo "age-Identity existiert bereits: $age_key"
                echo -n "Überschreiben? [j/N] "
                read -r confirm
                [[ "$confirm" != "j" && "$confirm" != "J" ]] && echo "Abgebrochen." && return 0
            fi
            mkdir -p "$(dirname "$age_key")"
            mkdir -p "$(dirname "$age_recipient")"
            age-keygen -o "$age_key"
            # Public Key extrahieren
            local pubkey
            pubkey=$(grep "^# public key: " "$age_key" | sed 's/# public key: //')
            echo "$pubkey" > "$age_recipient"
            chmod 600 "$age_key"
            chmod 644 "$age_recipient"
            echo ""
            echo "✅ Schlüsselpaar erzeugt."
            echo "   Identity:   $age_key"
            echo "   Recipient:  $age_recipient"
            echo ""
            echo " WICHTIG: Sichere $age_key auf ein externes Medium (z.B. 1Password)."
            echo "          Der Recipient ($age_recipient) darf ins Repo."
            ;;

        status)
            echo "age Identity:    $age_key"
            echo "age Recipient:   $age_recipient"
            echo "Secrets (plain): $secrets_file"
            echo "Secrets (age):   $encrypted_file"
            echo ""
            if [[ -f "$age_key" ]]; then
                echo "🔑 Identity vorhanden"
            else
                echo "❌ Identity fehlt → dotsec setup"
            fi
            if [[ -f "$secrets_file" ]]; then
                echo "🔓 Plaintext vorhanden ($(stat -f "%Sp" "$secrets_file" | tr -d ' ') | $(wc -c < "$secrets_file") bytes)"
            else
                echo "❌ Plaintext fehlt"
            fi
            if [[ -f "$encrypted_file" ]]; then
                echo "🔒 Verschlüsselte Datei vorhanden ($(wc -c < "$encrypted_file") bytes)"
            else
                echo "❌ Verschlüsselte Datei fehlt"
            fi
            ;;

        lock)
            if [[ ! -f "$secrets_file" ]]; then
                echo "Fehler: $secrets_file nicht gefunden"
                return 1
            fi
            if [[ ! -f "$age_recipient" ]]; then
                echo "Fehler: age Recipient nicht gefunden: $age_recipient"
                echo "        Tipp: dotsec setup"
                return 1
            fi
            mkdir -p "$(dirname "$encrypted_file")"
            age -r "$(cat "$age_recipient")" -o "$encrypted_file" "$secrets_file"
            chmod 600 "$encrypted_file"
            echo "🔒 Verschlüsselt: $encrypted_file"
            (
                local repo_dir
                repo_dir="${DOTFILES_DIR:-$HOME/dotfiles}"
                cd "$repo_dir" || return 1
                local rel_path="${encrypted_file#$repo_dir/}"
                git add "$rel_path"
                echo -n "Commit-Nachricht [dotsec: lock secrets]: "
                read -r msg
                [[ -z "$msg" ]] && msg="dotsec: lock secrets"
                git commit -m "$msg" && git push
            )
            ;;

        unlock)
            if [[ ! -f "$encrypted_file" ]]; then
                echo "Fehler: $encrypted_file nicht gefunden"
                echo "        Hast du git pull gemacht?"
                return 1
            fi
            if [[ ! -f "$age_key" ]]; then
                echo "Fehler: age Identity nicht gefunden: $age_key"
                echo "        Importiere deine Identity auf dieses Gerät."
                return 1
            fi
            mkdir -p "$(dirname "$secrets_file")"
            age -d -i "$age_key" -o "$secrets_file" "$encrypted_file"
            chmod 600 "$secrets_file"
            echo "🔓 Entschlüsselt: $secrets_file"
            ;;

        *)
            echo "Unbekannte Aktion: $action"
            echo "Tipp: dotsec --help"
            return 1
            ;;
    esac
}
