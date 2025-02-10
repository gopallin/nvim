local M = {}

local function opts(desc, bufnr)
  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

function M.setup_nvim_tree_keymaps(bufnr)
  local api = require("nvim-tree.api")
  local map = vim.keymap.set

  map("n", "a", api.fs.create, opts("Create", bufnr))
  map("n", "d", api.fs.remove, opts("Delete", bufnr))
  map("n", "r", api.fs.rename, opts("Rename/Update", bufnr))
  map("n", "<CR>", api.node.open.edit, opts("Open", bufnr))
  map("n", "yy", api.fs.copy.node, opts("Copy", bufnr))
  map("n", "p", api.fs.paste, opts("Paste", bufnr))
end

return M
