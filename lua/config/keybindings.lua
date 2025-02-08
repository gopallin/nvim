local function map(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end

map({'n', 'v'}, 'gg', 'gg^')
map({'n', 'v'}, 'G', 'Gg$')

map('n', '<leader>ad', "<cmd>lua require('avante').diff()<CR>")

vim.keymap.set('n', '<leader>av', function() require('avante').view() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ae', function() require('avante').some_correct_function() end, { noremap = true, silent = true })

map("n", "<leader>do", ":DiffviewOpen<CR>")
map("n", "<leader>dc", ":DiffviewClose<CR>")

map("n", "<leader>be", ":bnext<CR>")
map("n", "<leader>bd", ":bnext<CR>:bd#<CR>")
map("n", "<leader>bo", ":b#<CR>")

map("n", "<leader>e", ":NvimTreeToggle<CR>")

map("t", "<Esc>", "<C-\\><C-n>")
--map("n", "t", ":term<CR>")
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

local function switch_to_previous_buffer()
  local buffers = vim.fn.getbufinfo({ buflisted = true }) -- Get all listed buffers
  if #buffers > 1 then
    vim.cmd("b#") -- Switch to the previous buffer
  else
    vim.notify("No previous buffer available", vim.log.levels.INFO)
  end
end

vim.keymap.set("n", "<leader>bb", switch_to_previous_buffer, { noremap = true, silent = true })

local left_win_width = nil

local function toggle_left_diff_pane()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local left_diff_win = nil
  local min_col = math.huge

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    -- Ignore the file panel; if you have any other non-diff buffers, you might need to adjust this.
    if ft ~= "DiffviewFiles" then
      -- Get the window's (row, col) position on the screen.
      local pos = vim.api.nvim_win_get_position(win) -- returns {row, col}
      local col = pos[2]
      if col < min_col then
        min_col = col
        left_diff_win = win
      end
    end
  end

  if left_diff_win then
    -- Get current window width (using vim.fn.getwininfo for compatibility)
    local win_info = vim.fn.getwininfo(left_diff_win)[1]
    if win_info.width > 1 then
      -- Save the current width and reduce it (effectively hiding the pane)
      left_win_width = win_info.width
      vim.api.nvim_win_set_width(left_diff_win, 1)
    else
      -- Restore the original width (or default to 80 if unavailable)
      vim.api.nvim_win_set_width(left_diff_win, left_win_width or 80)
    end
  else
    vim.notify("Left diff pane not found!")
  end
end

vim.keymap.set("n", "<leader>z", toggle_left_diff_pane, { noremap = true, silent = true })

local terminal_buf = nil
local terminal_win = nil
local last_buf = nil   -- The file buffer you were in
local last_win = nil   -- The window where that file was displayed

local function open_terminal()
  -- Save the current buffer and window (the file you were editing)
  last_buf = vim.api.nvim_get_current_buf()
  last_win = vim.api.nvim_get_current_win()
  -- Open a terminal in a horizontal split at the bottom
  vim.cmd("botright split")
  vim.cmd("resize 15")
  vim.cmd("term")
  terminal_buf = vim.api.nvim_get_current_buf()
  terminal_win = vim.api.nvim_get_current_win()
end

local function toggle_terminal()
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    -- If the terminal window is visible, close it...
    vim.api.nvim_win_close(terminal_win, true)
    terminal_win = nil
    -- ...and defer switching back to the last window/buffer.
    vim.defer_fn(function()
      if last_win and vim.api.nvim_win_is_valid(last_win) then
        vim.api.nvim_set_current_win(last_win)
        vim.api.nvim_set_current_buf(last_buf)
      elseif last_buf and vim.api.nvim_buf_is_valid(last_buf) then
        vim.api.nvim_set_current_buf(last_buf)
      end
    end, 50)  -- Adjust the delay (in ms) if needed
  else
    -- Otherwise, save the current file buffer and window before reopening the terminal
    last_buf = vim.api.nvim_get_current_buf()
    last_win = vim.api.nvim_get_current_win()
    if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
      vim.cmd("botright split")
      vim.cmd("resize 15")
      vim.api.nvim_set_current_buf(terminal_buf)
      terminal_win = vim.api.nvim_get_current_win()
    else
      open_terminal()
    end
  end
end

-- Autocommand to automatically close the terminal window and return to the last file
vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function(args)
    if args.buf == terminal_buf then
      if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
        vim.api.nvim_win_close(terminal_win, true)
      end
      -- Defer the switch so that nvim-tree (or other sidebars) don't steal focus
      vim.defer_fn(function()
        if last_win and vim.api.nvim_win_is_valid(last_win) then
          vim.api.nvim_set_current_win(last_win)
          vim.api.nvim_set_current_buf(last_buf)
        elseif last_buf and vim.api.nvim_buf_is_valid(last_buf) then
          vim.api.nvim_set_current_buf(last_buf)
        end
        terminal_buf = nil
        terminal_win = nil
      end, 50)
    end
  end,
})

-- Keybindings:
-- "t" to open a terminal.
vim.keymap.set("n", "t", open_terminal, { noremap = true, silent = true })
-- "<leader>t" to toggle the terminal.
vim.keymap.set("n", "<leader>t", toggle_terminal, { noremap = true, silent = true })


return {
  setup_nvim_tree_keymaps = setup_nvim_tree_keymaps,
  jump_to_last_buffer = jump_to_last_buffer,
  switch_to_previous_buffer = switch_to_previous_buffer,
  toggle_left_diff_pane = toggle_left_diff_pane,
}
