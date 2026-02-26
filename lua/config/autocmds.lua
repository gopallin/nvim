local terminal = require('utility.terminal')
local autocmd = require('utility.autocmds')
local telescope = require('utility.telescope')

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.lsp.buf.document_highlight()
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    vim.lsp.buf.clear_references()
    telescope.clear_git_blame()
    autocmd.flash_cursor_line_on_line_change()
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    if args.data.filetype ~= "help" then
      vim.wo.number = true
    elseif args.data.bufname:match("*.csv") then
      vim.wo.wrap = false
    end
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    telescope.show_git_blame()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function(args)
    terminal.close_terminal_callback(args)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = { "en_us" }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.cmd([[syntax match MyCamelCase_1 /\<[a-z]\+[A-Z][a-zA-Z0-9]*\>/ contains=@NoSpell]])
    vim.cmd([[syntax match MyCamelCase_2 /\<[A-Z][a-z]\+[A-Z][a-zA-Z0-9]*\>/ contains=@NoSpell]])
  end,
})
