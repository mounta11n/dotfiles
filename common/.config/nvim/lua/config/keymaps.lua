-- Eigene Keymaps

-- Leader auf Leertaste (Standard in modernen Neovim-Setups)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Schnelleres Speichern & Beenden (direkt ohne Leader)
map("n", "w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "q", "<cmd>q<cr>", { desc = "Quit window" })
--map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Buffer-Navigation (wie Tabs in Vim)
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Fenster-Navigation mit Ctrl + hjkl (vim-gewohnt)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Zeilen verschieben im Visual Mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Zentrieren bei Sprüngen
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next match and center" })
map("n", "N", "Nzzzv", { desc = "Prev match and center" })

-- mini.files: Datei-Explorer (Miller Columns) togglen
map("n", "<leader>e", function()
  local MiniFiles = require("mini.files")
  if not MiniFiles.close() then
    MiniFiles.open(vim.api.nvim_buf_get_name(0), { close_on_action = false })
  end
end, { desc = "Toggle file explorer" })

-- mini.pick: Fuzzy-Finder Keymaps
map("n", "<leader>ff", function()
  require("mini.pick").builtin.files({ tool = "git" })
end, { desc = "Find files" })
map("n", "<leader>fg", function()
  require("mini.pick").builtin.grep_live()
end, { desc = "Live grep" })
map("n", "<leader>fb", function()
  require("mini.pick").builtin.buffers()
end, { desc = "Find buffers" })
map("n", "<leader>fh", function()
  require("mini.pick").builtin.help()
end, { desc = "Find help" })

