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

local fzf_lua = require("fzf-lua")

local function show_git_blame()
  local file = vim.fn.expand("%:p")
  if file == "" or vim.bo.filetype == "nofile" then
    return
  end
  local cmd = string.format("git blame %s", file)
  fzf_lua.fzf_exec(cmd, {
    preview = "git show {1}",
    actions = {
      ["default"] = function(selected)
        print("Commit:", selected[1])
      end,
    },
  })
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    show_git_blame()
  end,
})

