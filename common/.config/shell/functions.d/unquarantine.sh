unquarantine() {
    if [ -z "$1" ]; then
        echo "Fehler: Bitte App-Namen angeben (z.B. unquarantine /Applications/Spotify.app)"
        return 1
    fi
    sudo xattr -d com.apple.quarantine "$1"
}

