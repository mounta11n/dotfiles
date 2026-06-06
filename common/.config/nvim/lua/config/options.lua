-- Basis-Optionen für Neovim
-- (Wenn du von Vim kommst: die meisten Optionen kennst du bestimmt schon!)

-- Zeilennummern
vim.opt.number = true
vim.opt.relativenumber = false

-- Tabs / Einrückung (konservative Defaults)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Kein Zeilenumbruch, lieber horizontal scrollen
vim.opt.wrap = false

-- Suche
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Mehr Kontext beim Scrollen
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Clipboard-Integration mit dem System (macOS)
vim.opt.clipboard = "unnamedplus"

-- Undo-Persistenz (auch nach Neustart)
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Split-Richtung wie in Vim gewohnt
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Schnelleres Completion-Menü
vim.opt.updatetime = 200

-- Anzeige von Whitespace (nur trailing – deaktiviere mit :set nolist)
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
