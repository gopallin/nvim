local function map(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end

local mason = require('config.keybindings.mason')
local bufferline = require('config.keybindings.bufferline')
local diffview = require('config.keybindings.diffview')
local terminal = require('config.keybindings.terminal')

map({'n', 'v'}, 'gg', 'gg^')
map({'n', 'v'}, 'G', 'Gg$')

map("n", "<leader>do", ":DiffviewOpen<CR>")
map("n", "<leader>dc", ":DiffviewClose<CR>")

map("n", "<leader>be", ":bnext<CR>")
map("n", "<leader>bd", ":bnext<CR>:bd#<CR>")
map("n", "<leader>bo", ":b#<CR>")

map("n", "<leader>e", ":NvimTreeToggle<CR>")

map("t", "<Esc>", "<C-\\><C-n>")
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
map("n", "<leader>li", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>") -- LSP implementations
-- Map <leader>lr to toggle the LSP references
map("n", "<leader>lr", mason.toggle_lsp_references)

for i = 1, 8 do
  map("n", "<leader>" .. tostring(i), ":BufferLineGoToBuffer " .. i .. "<CR>")
end

map("n", "<leader>9", bufferline.jump_to_last_buffer)
map("n", "<leader>bb", bufferline.switch_to_previous_buffer)

map("n", "<leader>z", diffview.toggle_left_diff_pane)

map("n", "t", terminal.open_terminal)
map("n", "<leader>t", terminal.toggle_terminal)
