-- vim.cmd("colorscheme vim")
-- vim.cmd("colorscheme lackluster")
vim.cmd.colorscheme("anysphere")

vim.api.nvim_set_hl(0, "Search", { fg = "#1f2335", bg = "#e5c07b", bold = true })
vim.api.nvim_set_hl(0, "CurSearch", { fg = "#1f2335", bg = "#ff7aa2", bold = true })
vim.api.nvim_set_hl(0, "IncSearch", { link = "CurSearch" })

--vim.cmd("highlight CursorLine ctermbg=black guibg=black")
--vim.cmd("highlight CursorColumn ctermbg=black guibg=black")

-- vim.api.nvim_set_hl(0, "javaScriptParens", { link = "NonText" })
-- vim.api.nvim_set_hl(0, "phpRegion", { link = "DevIconElisp" })
-- vim.api.nvim_set_hl(0, "Comment", { link = "DevIconAsc" })
