local M = {}

local terminal_buf = nil
local terminal_win = nil
local last_buf = nil   -- the file buffer you were in
local last_win = nil   -- the window where that file was displayed

local function open_terminal()
  last_buf = vim.api.nvim_get_current_buf()
  last_win = vim.api.nvim_get_current_win()
  vim.cmd("botright split")
  vim.cmd("resize 15")
  vim.cmd("term")
  terminal_buf = vim.api.nvim_get_current_buf()
  terminal_win = vim.api.nvim_get_current_win()
end

local function toggle_terminal()
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    vim.api.nvim_win_close(terminal_win, true)
    terminal_win = nil
    vim.defer_fn(function()
      if last_win and vim.api.nvim_win_is_valid(last_win) then
        vim.api.nvim_set_current_win(last_win)
        vim.api.nvim_set_current_buf(last_buf)
      elseif last_buf and vim.api.nvim_buf_is_valid(last_buf) then
        vim.api.nvim_set_current_buf(last_buf)
      end
    end, 50)
  else
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

vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function(args)
    if args.buf == terminal_buf then
      if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
        vim.api.nvim_win_close(terminal_win, true)
      end
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

M.open_terminal = open_terminal
M.toggle_terminal = toggle_terminal

return M

