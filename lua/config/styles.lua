-- vim.cmd("colorscheme vim")
-- vim.cmd("colorscheme lackluster")
vim.cmd.colorscheme("anysphere")

vim.api.nvim_set_hl(0, "Search", { fg = "#1f2335", bg = "#e5c07b", bold = true })
vim.api.nvim_set_hl(0, "CurSearch", { fg = "#1f2335", bg = "#ff7aa2", bold = true })
vim.api.nvim_set_hl(0, "IncSearch", { link = "CurSearch" })

-- render-markdown.nvim: anysphere paints every markdown group the same yellow,
-- so give each heading level its own palette colour with a tinted background.
vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#94c1fa", bold = true }) -- softblue
vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = "#94c1fa", bg = "#2e3641", bold = true })
vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#aaa0fa", bold = true }) -- purple
vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = "#aaa0fa", bg = "#323041", bold = true })
vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#e394dc", bold = true }) -- magenta
vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = "#e394dc", bg = "#3d2e3b", bold = true })
vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#efb080", bold = true }) -- orange
vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = "#efb080", bg = "#3f332b", bold = true })
vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#83d6c5", bold = true }) -- cyan
vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = "#83d6c5", bg = "#2b3a37", bold = true })
vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#98c379", bold = true }) -- green
vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = "#98c379", bg = "#2f3729", bold = true })
vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#242424" })
vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { fg = "#efb080", bg = "#2a2a2a" })
vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#83d6c5" })
vim.api.nvim_set_hl(0, "RenderMarkdownDash", { fg = "#5b5b5b" })
vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", { fg = "#94c1fa", bold = true })
vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", { fg = "#6d6d6d" })
vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = "#98c379" })
vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = "#9ca3b2" })
vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = "#94c1fa", underline = true })

--vim.cmd("highlight CursorLine ctermbg=black guibg=black")
--vim.cmd("highlight CursorColumn ctermbg=black guibg=black")

-- vim.api.nvim_set_hl(0, "javaScriptParens", { link = "NonText" })
-- vim.api.nvim_set_hl(0, "phpRegion", { link = "DevIconElisp" })
-- vim.api.nvim_set_hl(0, "Comment", { link = "DevIconAsc" })
