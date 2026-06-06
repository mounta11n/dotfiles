-- Neovim-Konfiguration mit nord.nvim Theme + mini.nvim
-- Nutzt den built-in vim.pack (ab Neovim 0.12)

--- 1. Basis-Config zuerst laden --------
require("config.options")
require("config.keymaps")
require("config.autocmds")

--- 2. Plugins via vim.pack installieren --------
vim.pack.add({
  -- Nord Theme
  { src = "https://github.com/gbprod/nord.nvim" },
  -- mini.nvim (ausgewählte Module)
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

--- 3. mini.nvim Module setuppen --------

-- mini.icons (Basis für Icons, wird von anderen Modulen benötigt)
require("mini.icons").setup()

-- mini.pairs (automatische Klammern-Paare)
require("mini.pairs").setup()

-- mini.comment (gc zum Kommentieren)
require("mini.comment").setup()

-- mini.ai (erweiterte Text-Objekte: ii, ai, i(, a(, if, af, etc.)
-- Dot-repeatable, v:count, built-in für Brackets/Quotes/Tags/Arguments
require("mini.ai").setup()

-- mini.surround (Surround-Operationen: sa, sd, sr, sf, sh)
-- sa" → fügt "" hinzu, sd" → löscht, sr"' → ersetzt "" mit ''
require("mini.surround").setup()

-- mini.snippets (Snippet-Engine, expand mit <C-j>)
-- Lädt globale + sprachspezifische Snippets aus ~/.config/nvim/snippets/
require("mini.snippets").setup({
  snippets = {
    require("mini.snippets").gen_loader.from_file("~/.config/nvim/snippets/global.json"),
    require("mini.snippets").gen_loader.from_lang(),
  },
})

-- mini.indentscope (Einrückungs-Anzeige)
require("mini.indentscope").setup({
  symbol = "╎",
  options = { indent_at_cursor = false },
})

-- mini.hipatterns (TODO/FIXME/Hex-Farben hervorheben)
require("mini.hipatterns").setup({
  highlighters = {
    fixme      = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack       = { pattern = "%f[%w]()HACK()%f[%W]",  group = "MiniHipatternsHack"  },
    todo       = { pattern = "%f[%w]()TODO()%f[%W]",  group = "MiniHipatternsTodo"  },
    note       = { pattern = "%f[%w]()NOTE()%f[%W]",  group = "MiniHipatternsNote"  },
    hex_color  = require("mini.hipatterns").gen_highlighter.hex_color(),
  },
})

-- mini.notify (schöneres Notification-System)
require("mini.notify").setup()
vim.notify = require("mini.notify").make_notify()

-- mini.statusline (eigene Statuszeile)
require("mini.statusline").setup()

-- mini.tabline (Buffer-Tabs oben)
require("mini.tabline").setup()

-- mini.files (Datei-Explorer, ersetzt nvim-tree)
require("mini.files").setup({
  options = {
    use_as_default_explorer = true,
  },
  windows = {
    preview = true,
    width_focus = 50,
    width_nofocus = 20,
    width_preview = 30,
  },
})

-- mini.git (Git-Integration)
require("mini.git").setup()

-- mini.diff (Git Sign Column, ersetzt gitsigns)
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "▒", change = "▒", delete = "▒" },
  },
})

-- mini.pick (Fuzzy-Finder)
require("mini.pick").setup()

-- mini.starter (Startbildschirm)
require("mini.starter").setup({
  autoopen = true,
})

-- mini.clue (Keymap-Hinweise, ersetzt which-key)
-- **Wichtig**: Falls Clue mit existierenden Buffer-Local Mappings kollidiert,
--             `:lua MiniClue.ensure_buf_triggers()` ausführen.
local MiniClue = require("mini.clue")
MiniClue.setup({
  triggers = {
    -- Leader-Triggler (zeigt alle <Leader>-Mappings)
    { mode = { "n", "x" }, keys = "<Leader>" },
    -- `[` und `]` für Buffer-Navigation ([b, ]b)
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    -- Built-in Completion
    { mode = "i", keys = "<C-x>" },
    -- `g` key
    { mode = { "n", "x" }, keys = "g" },
    -- Marks
    { mode = { "n", "x" }, keys = "'" },
    { mode = { "n", "x" }, keys = "`" },
    -- Registers
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },
    -- Window commands
    { mode = "n", keys = "<C-w>" },
    -- `z` key
    { mode = { "n", "x" }, keys = "z" },
  },
  clues = {
    MiniClue.gen_clues.square_brackets(),
    MiniClue.gen_clues.builtin_completion(),
    MiniClue.gen_clues.g(),
    MiniClue.gen_clues.marks(),
    MiniClue.gen_clues.registers(),
    MiniClue.gen_clues.windows(),
    MiniClue.gen_clues.z(),
  },
  window = {
    delay = 500, -- Clue-Fenster erscheint nach 500ms (etwas schneller als Default)
  },
})

--- 4. Nord Theme aktivieren (nach Plugin-Setups) --------
require("nord").setup({
  transparent = false,
  terminal_colors = true,
  borders = true,
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
  },
})
vim.cmd.colorscheme("nord")

