

unquarantine() {
    if [ -z "$1" ]; then
        echo "Fehler: Bitte App-Namen angeben (z.B. unquarantine Spotify)"
        return 1
    fi
    sudo xattr -d com.apple.quarantine "/Applications/$1"
}



y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
