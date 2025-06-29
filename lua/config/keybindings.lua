local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

local mason = require('utility.mason')
local bufferline = require('utility.bufferline')
local terminal = require('utility.terminal')
local fzf = require('utility.fzf')
local wrap = require('utility.wrap')

map({'n', 'v'}, 'gg', 'gg^')
map({'n', 'v'}, 'G', 'Gg$')
map({'n', 'v'}, 'x', '"_x')

map("n", "<leader>do", ":DiffviewOpen<CR>")
map("n", "<leader>dc", ":DiffviewClose<CR>")

map("n", "<leader>e", ":NvimTreeToggle<CR>")

map("t", "<Esc>", "<C-\\><C-n>")
map('n', 'm', ':Format<CR>')
map('v', 'q', ":m '<-2<CR>gv=gv")
map('v', 'z', ":m '>+1<CR>gv=gv")
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

map("x", "p", '"0p')

-- Scroll viewport without moving cursor
map('n', '<C-e>', '9<C-e>')  -- Scroll down
map('n', '<C-y>', '9<C-y>')  -- Scroll up

-- Files and Search
map("n", "<leader>fe", fzf.show_diagnostics_in_fzf)
map("n", "<leader>ff", fzf.files)
map("n", "<leader>fg", fzf.live_grep)
map("n", "<leader>fb", fzf.buffers)
map("n", "<leader>fh", fzf.help_tags)

-- Git integration
map("n", "<leader>gc", fzf.git_commits)
map("n", "<leader>gs", fzf.git_status)
map("n", "<leader>gb", fzf.show_git_blame)

-- LSP-related keybindings
map("n", "<leader>ld", vim.lsp.buf.definition) -- Go to LSP definition directly
map("n", "<leader>li", fzf.lsp_implementations)
-- Map <leader>lr to toggle the LSP references
map("n", "<leader>lr", mason.toggle_lsp_references)

for i = 1, 8 do
  map("n", "<leader>" .. i, function() bufferline.jump_to_buffer_at(i) end)
end

map("n", "<leader>9", bufferline.jump_to_last_buffer)
map("n", "<leader>bb", bufferline.switch_to_previous_buffer)
map("n", "<leader>ba", bufferline.close_others_in_group)
map("n", "<leader>be", ":bnext<CR>")
-- map("n", "<leader>bd", ":bnext<CR>:bd#<CR>")
map("n", "<leader>bd", bufferline.close_current_buffer)
map("n", "<leader>bo", ":b#<CR>")

map("n", "t", terminal.open_terminal)
map("n", "<leader>t", terminal.toggle_terminal)
map('n', '<leader>ht', bufferline.toggle_terminal_buffers)

for open, _ in pairs(wrap.pairs) do
  map('v', open, function() wrap.wrap_selection(open) end)
end
