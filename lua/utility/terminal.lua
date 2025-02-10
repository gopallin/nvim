local M = {}

local terminal_buf = nil
local terminal_win = nil
local last_buf = nil   -- the file buffer you were in
local last_win = nil   -- the window where that file was displayed

-- Helper: determine if a buffer is a “real” file (and not nvim-tree, etc.)
local function is_real_buffer(buf)
  local ft = vim.bo[buf].filetype
  return ft ~= "NvimTree" and ft ~= ""
end

local function open_terminal()
  -- capture the original file buffer/window only if it’s a real buffer.
  local cur_buf = vim.api.nvim_get_current_buf()
  if is_real_buffer(cur_buf) then
    last_buf = cur_buf
    last_win = vim.api.nvim_get_current_win()
  else
    -- if the current buffer isn’t a “real” file, try to find one
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if is_real_buffer(buf) then
        last_buf = buf
        last_win = win
        break
      end
    end
  end

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
    -- Use vim.schedule to run the restore after the terminal is closed.
    vim.schedule(function()
      if last_win and vim.api.nvim_win_is_valid(last_win) then
        local buf = vim.api.nvim_win_get_buf(last_win)
        -- if the saved window is showing nvim-tree, try to find another valid window.
        if not is_real_buffer(buf) then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local b = vim.api.nvim_win_get_buf(win)
            if is_real_buffer(b) then
              last_win = win
              last_buf = b
              break
            end
          end
        end
        vim.api.nvim_set_current_win(last_win)
        vim.api.nvim_set_current_buf(last_buf)
      elseif last_buf and vim.api.nvim_buf_is_valid(last_buf) then
        vim.api.nvim_set_current_buf(last_buf)
      end
    end)
  else
    -- (Re)capture the original file buffer/window (if possible) before opening terminal.
    local cur_buf = vim.api.nvim_get_current_buf()
    if is_real_buffer(cur_buf) then
      last_buf = cur_buf
      last_win = vim.api.nvim_get_current_win()
    end

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

-- This callback is triggered when the terminal buffer is closed (for example, when you type "exit")
local function close_terminal_callback(args)
  if args.buf == terminal_buf then
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
      vim.api.nvim_win_close(terminal_win, true)
    end
    vim.schedule(function()
      if last_win and vim.api.nvim_win_is_valid(last_win) then
        local buf = vim.api.nvim_win_get_buf(last_win)
        if not is_real_buffer(buf) then
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local b = vim.api.nvim_win_get_buf(win)
            if is_real_buffer(b) then
              last_win = win
              last_buf = b
              break
            end
          end
        end
        vim.api.nvim_set_current_win(last_win)
        vim.api.nvim_set_current_buf(last_buf)
      elseif last_buf and vim.api.nvim_buf_is_valid(last_buf) then
        vim.api.nvim_set_current_buf(last_buf)
      end
      terminal_buf = nil
      terminal_win = nil
    end)
  end
end

M.open_terminal = open_terminal
M.toggle_terminal = toggle_terminal
M.close_terminal_callback = close_terminal_callback

return M

