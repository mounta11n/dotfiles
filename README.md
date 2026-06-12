# Dotfiles

Stow-basierte Dotfiles für macOS & Linux.

## Struktur

```
├── agents/     # Agent-spezifische Tools & Konfiguration
├── common/     # Plattform-übergreifende Konfiguration (Shell, TUI, etc.)
├── linux/      # Linux-spezifische Konfiguration
└── macos/      # macOS-spezifische Konfiguration
```

## Erst-Einrichtung

```bash
# 1. Repo klonen
cd ~ && git clone <repo-url> dotfiles && cd dotfiles

# 2. Packages stowen (je nach Gerät)
stow common
stow macos    # oder: stow linux
stow agents   # falls gewünscht

# 3. Secrets entsperren (falls vorhanden)
dotsec unlock
```

## Tools

### `wots` — "stow" rückwärts

Bringt eine Datei oder einen Ordner aus dem Home-Verzeichnis ins Repo:

```bash
wots ~/.config/ghostty/config macos
wots ~/.vimrc common
wots ~/.config/btop/config linux
```

Ohne Target-Argument wird interaktiv nach dem Package gefragt.
Was `wots` macht:
1. Backup nach `~/dotfiles/.backup/<timestamp>/`
2. Verschiebt ins richtige Stow-Package
3. Erstellt Symlink zurück zum Originalpfad
4. Git: `pull → add → commit → push`

### `dotsec` — Secrets verwalten

Verschlüsselt `~/.config/shell/secrets.zsh` mit [age](https://github.com/FiloSottile/age):

```bash
dotsec setup    # Einmalig: Schlüsselpaar erzeugen
dotsec lock     # Nach Änderungen: verschlüsseln + git push
dotsec unlock   # Auf neuem Gerät: entschlüsseln
dotsec status   # Übersicht anzeigen
```

## Secrets-Strategie

- Unverschlüsselte Secrets landen **nie** im Repo.
- `~/.config/shell/secrets.zsh` wird von der `.zshrc` geladen.
- Die verschlüsselte `secrets.zsh.age` liegt im Repo unter `common/.config/shell/`.
- `age` ist die einzige zusätzliche Abhängigkeit.
