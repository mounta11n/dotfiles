-- Autocmds (automatische Befehle)

-- Hilfe-Fenster automatisch verlassen mit q
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "lspinfo", "checkhealth", "qf" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Cursor-Line nur im aktiven Fenster anzeigen
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    vim.opt.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    vim.opt.cursorline = false
  end,
})
