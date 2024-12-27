local function map(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end

map({'n', 'v'}, 'gg', 'gg^')
map({'n', 'v'}, 'G', 'Gg$')

map("n", "<leader>do", ":DiffviewOpen<CR>")
map("n", "<leader>dc", ":DiffviewClose<CR>")

map("n", "<leader>be", ":bnext<CR>")
map("n", "<leader>bb", "<C-^>")
map("n", "<leader>bd", ":bnext<CR>:bd#<CR>")
map("n", "<leader>bo", ":b#<CR>")

map("n", "<leader>e", ":NvimTreeToggle<CR>")
map("n", "<leader>g", ":NvimTreeFindFile<CR>")

map("t", "<Esc>", "<C-\\><C-n>")
map("n", "t", ":term<CR>")
map('n', 'm', ':Format<CR>')
map('v', 'q', ":m '<-2<CR>gv=gv")
map('v', 'z', ":m '>+1<CR>gv=gv")
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

-- Scroll viewport without moving cursor
map('n', '<C-e>', '7<C-e>')  -- Scroll down
map('n', '<C-y>', '7<C-y>')  -- Scroll up

-- Files and Search
map("n", "<leader>fe", ":lua require('config.fzf-diagnostics').show_diagnostics_in_fzf()<CR>")
map("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>")       -- Find files
map("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>")   -- Live grep
map("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>")     -- Open buffers
map("n", "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>")   -- Help tags

-- Git integration
map("n", "<leader>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>") -- Git commits
map("n", "<leader>gs", "<cmd>lua require('fzf-lua').git_status()<CR>")  -- Git status

-- LSP-related keybindings
map("n", "<leader>ld", vim.lsp.buf.definition) -- Go to LSP definition directly
--map("n", "<leader>lr", "<cmd>lua require('fzf-lua').lsp_references({ action = 'edit' })<CR>")  -- LSP references with fzf-lua
map("n", "<leader>li", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>") -- LSP implementations

-- Function to toggle LSP references
local lsp_references_open = false

local function toggle_lsp_references()
  if lsp_references_open then
    -- Close the window if it's already open
    vim.cmd("cclose")
    lsp_references_open = false
  else
    -- Show LSP references and set the flag to open
    vim.lsp.buf.references()
    lsp_references_open = true
  end
end

-- Map <leader>lr to toggle the LSP references
map("n", "<leader>lr", toggle_lsp_references)


for i = 1, 8 do
  map("n", "<leader>" .. tostring(i), ":BufferLineGoToBuffer " .. i .. "<CR>")
end

map("n", "<leader>9", "<cmd>lua require('config.keybindings').jump_to_last_buffer()<CR>")

local function setup_nvim_tree_keymaps(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  map("n", "a", api.fs.create, opts("Create"))
  map("n", "d", api.fs.remove, opts("Delete"))
  map("n", "r", api.fs.rename, opts("Rename/Update"))
  map("n", "<CR>", api.node.open.edit, opts("Open"))
  map("n", "yy", api.fs.copy.node, opts("Copy"))
  map("n", "p", api.fs.paste, opts("Paste"))
end

local function jump_to_last_buffer()
  local last_buffer_index = #vim.fn.getbufinfo({ buflisted = true })
  vim.cmd("BufferLineGoToBuffer " .. last_buffer_index)
end

return {
  setup_nvim_tree_keymaps = setup_nvim_tree_keymaps,
  jump_to_last_buffer = jump_to_last_buffer,
}
