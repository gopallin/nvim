local function map(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local opt = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<C-p>", ":Telescope find_files<CR>", opt)
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

map("n", "<leader>do", ":DiffviewOpen<CR>", opt)
map("n", "<leader>dc", ":DiffviewClose<CR>", opt)

map("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true })
map("n", "<leader>bp", ":bprev<CR>", { noremap = true, silent = true })
map("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true })

map("n", "<leader>e", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>g", ":NvimTreeFindFile<CR>", opt)

map("n", "t", ":term<CR>", opt)

local function setup_nvim_tree_keymaps(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename/Update"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
end

return {
  setup_nvim_tree_keymaps = setup_nvim_tree_keymaps,
}
