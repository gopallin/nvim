vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.lsp.buf.document_highlight()
  end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    vim.lsp.buf.clear_references()
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

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight CursorLine ctermbg=darkgrey guibg=darkgrey")
    vim.cmd("highlight CursorColumn ctermbg=darkgrey guibg=darkgrey")
  end,
})

local function show_git_blame()
  local line_number = vim.fn.line('.')
  local blame_output = vim.fn.systemlist('git blame -L ' .. line_number .. ',' .. line_number .. ' --porcelain')

  if not blame_output or #blame_output == 0 then
    return
  end

  local commit_hash = string.match(blame_output[1], "^%w+")
  local commit_message = vim.fn.system('git show -s --format=%s ' .. commit_hash)

  if commit_message and #commit_message > 0 then
    -- Display commit message in the command line
    vim.api.nvim_echo({{ commit_message, 'Normal' }}, false, {})
  end
end

vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    show_git_blame()
  end,
})

