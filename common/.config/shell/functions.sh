# ———————————————————————————————
#  functions.sh — Funktions-Loader
# ———————————————————————————————

# Auto-load functions.d/*.sh
for _wots_f in "$SHELL_CONFIG_DIR"/functions.d/*.sh(N); do
	source "$_wots_f"
done
unset _wots_f
