# ———————————————————————————————
#  os.zsh — OS-spezifische Config
# ———————————————————————————————

case "$(uname -s)" in
  Darwin)
    # macOS: Brew's OpenJDK
    export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include -I/usr/local/include"
    export LDFLAGS="-L/usr/local/lib"
    ;;
  Linux)
    # Linux-spezifische Pfade / Flags
    # export CPPFLAGS="..."
    # export LDFLAGS="..."
    ;;
esac
