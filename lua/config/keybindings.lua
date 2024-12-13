local function map(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

local opt = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<leader>do", ":DiffviewOpen<CR>", opt)
map("n", "<leader>dc", ":DiffviewClose<CR>", opt)

map("n", "<leader>be", ":bnext<CR>", { noremap = true, silent = true })
map("n", "<leader>bb", ":bprev<CR>", { noremap = true, silent = true })
map("n", "<leader>bd", ":bnext<CR>:bd#<CR>", { noremap = true, silent = true })

map("n", "<leader>e", ":NvimTreeToggle<CR>", opt)
map("n", "<leader>g", ":NvimTreeFindFile<CR>", opt)

map("n", "t", ":term<CR>", opt)
map('n', 'm', ':Format<CR>', { noremap = true, silent = true })
map('v', 'q', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map('v', 'z', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map('v', '<Tab>', '>gv', { noremap = true, silent = true })
map('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

-- Scroll viewport without moving cursor
map('n', '<C-e>', '7<C-e>', { noremap = true })  -- Scroll down
map('n', '<C-y>', '7<C-y>', { noremap = true })  -- Scroll up

-- Files and Search
map("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", opt)       -- Find files
map("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>", opt)   -- Live grep
map("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", opt)     -- Open buffers
map("n", "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>", opt)   -- Help tags

-- Git integration
map("n", "<leader>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>", opt) -- Git commits
map("n", "<leader>gs", "<cmd>lua require('fzf-lua').git_status()<CR>", opt)  -- Git status

-- LSP-related keybindings
map("n", "<leader>ld", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opt) -- LSP definitions
map("n", "<leader>lr", "<cmd>lua require('fzf-lua').lsp_references()<CR>", opt)  -- LSP references
map("n", "<leader>li", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opt) -- LSP implementations

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
