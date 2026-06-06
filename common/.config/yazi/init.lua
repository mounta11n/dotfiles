require("sshfs"):setup()

require("session"):setup {
	sync_yanked = true,
}

require("zoxide"):setup {
	update_db = true,
}

require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}

require("mactag"):setup {
	-- Keys used to add or remove tags
	keys = {
		r = "Rot",
		o = "Orange",
		y = "Gelb",
		g = "Grün",
		b = "Blau",
		p = "Lila",
	},
	-- Colors used to display tags
	colors = {
		Red    = "#ee7b70",
		Orange = "#f5bd5c",
		Yellow = "#fbe764",
		Green  = "#91fc87",
		Blue   = "#5fa3f8",
		Purple = "#cb88f8",
	},
	-- Order of the color circle showing in the line mode
	order = 500,
}
