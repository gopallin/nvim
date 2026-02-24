local M = {}

-- Table to track multiple terminal sessions.
-- Each session is a table: { buf = <buffer id>, win = <window id or nil>, last_active = <timestamp> }
local terminals = {}

local last_buf = nil  -- last active file buffer (to restore when toggling off)
local last_win = nil  -- last active file window

-- Helper: determine if a buffer is a "real" file (and not, e.g., nvim-tree)
local function is_real_buffer(buf)
  local ft = vim.bo[buf].filetype
  return ft ~= "NvimTree" and ft ~= ""
end

-- Helper: Check if a given window is at (or near) the bottom of the screen.
local function is_bottom_window(win)
  local pos = vim.fn.win_screenpos(win)  -- returns {row, col} of the window's top-left corner
  local height = vim.api.nvim_win_get_height(win)
  local bottom = pos[1] + height - 1
  local total_rows = vim.o.lines - vim.o.cmdheight
  return bottom >= total_rows - 1  -- allow a margin of 1 line
end

-- Look through our sessions and return the one whose window is visible at the bottom.
local function get_bottom_terminal_session()
  for _, session in ipairs(terminals) do
    if session.win and vim.api.nvim_win_is_valid(session.win) then
      if is_bottom_window(session.win) then
        return session
      end
    end
  end
  return nil
end

-- Look for the most-recently active session that is not currently visible (win is nil or invalid)
local function get_last_inactive_terminal_session()
  local candidate = nil
  for _, session in ipairs(terminals) do
    if not (session.win and vim.api.nvim_win_is_valid(session.win)) then
      if not candidate or session.last_active > candidate.last_active then
        candidate = session
      end
    end
  end
  return candidate
end

-- Helper: Create a new terminal session at the bottom.
local function open_new_terminal()
  -- Capture the current file buffer/window if it’s a "real" file.
  local cur_buf = vim.api.nvim_get_current_buf()
  if is_real_buffer(cur_buf) then
    last_buf = cur_buf
    last_win = vim.api.nvim_get_current_win()
  else
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
  vim.cmd("enew") -- Create a new empty buffer for the terminal
  vim.cmd("resize 20")
  -- If Neovim runs via sudo, start terminal as the invoking user instead of root.
  -- Fall back to the current shell user when no non-root target is available.
  local cwd = vim.fn.getcwd()
  local target_user = vim.env.SUDO_USER or vim.env.USER or ""
  local term_cmd

  if target_user ~= "" and target_user ~= "root" then
    term_cmd = { "sudo", "-u", target_user, vim.o.shell, "-l" }
  else
    term_cmd = { vim.o.shell, "-l" }
  end

  vim.fn.termopen(term_cmd, { cwd = cwd })
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local session = { buf = buf, win = win, last_active = os.time() }
  table.insert(terminals, session)
end

-- open_terminal(): When pressing "t"
-- If a terminal is already visible at the bottom, do nothing.
-- Otherwise, always create a new terminal at the bottom.
local function open_terminal()
  if get_bottom_terminal_session() then
    return
  end
  open_new_terminal()
end

-- toggle_terminal(): When pressing "<leader>t"
-- 1. If a terminal is visible at the bottom, close it and update its last_active time.
-- 2. If no terminal is visible, then check for an existing inactive session.
--    If one exists, re-open that session at the bottom.
-- 3. Otherwise, create a new terminal session.
local function toggle_terminal()
  local bottom_session = get_bottom_terminal_session()

  -- Save the current window and buffer before switching to the terminal
  if not bottom_session then
    last_win = vim.api.nvim_get_current_win()
    last_buf = vim.api.nvim_get_current_buf()
  end

  if bottom_session then
    if vim.api.nvim_win_is_valid(bottom_session.win) then
      vim.api.nvim_win_close(bottom_session.win, true)
    end
    bottom_session.win = nil
    bottom_session.last_active = os.time()

    vim.schedule(function()
      -- Restore last active buffer/window
      if last_win and vim.api.nvim_win_is_valid(last_win) and last_buf and vim.api.nvim_buf_is_valid(last_buf) then
        vim.api.nvim_set_current_win(last_win)
        vim.api.nvim_set_current_buf(last_buf)
      elseif last_buf and vim.api.nvim_buf_is_valid(last_buf) then
        vim.api.nvim_set_current_buf(last_buf)
      else
        -- Fallback to any valid non-terminal buffer
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if is_real_buffer(buf) and vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_set_current_win(win)
            vim.api.nvim_set_current_buf(buf)
            last_buf = buf
            last_win = win
            break
          end
        end
      end
    end)
    return
  end

  -- No terminal currently visible, check for an inactive session.
  local inactive = get_last_inactive_terminal_session()
  if inactive and vim.api.nvim_buf_is_valid(inactive.buf) then
    vim.cmd("botright split")
    vim.cmd("resize 20")
    vim.api.nvim_set_current_buf(inactive.buf)
    inactive.win = vim.api.nvim_get_current_win()
    return
  end

  -- No inactive session available, create a new terminal.
  open_new_terminal()
end

-- Callback: Triggered when a terminal buffer is closed (e.g. user types "exit")
local function close_terminal_callback(args)
  for i, session in ipairs(terminals) do
    if session.buf == args.buf then
      if session.win and vim.api.nvim_win_is_valid(session.win) then
        vim.api.nvim_win_close(session.win, true)
      end
      table.remove(terminals, i)
      -- Update last_buf/last_win if they match the closed buffer
      if last_buf == args.buf then
        last_buf = nil
        last_win = nil
      end
      break
    end
  end
  vim.schedule(function()
    if last_win and vim.api.nvim_win_is_valid(last_win) and last_buf and vim.api.nvim_buf_is_valid(last_buf) then
      vim.api.nvim_set_current_win(last_win)
      vim.api.nvim_set_current_buf(last_buf)
    elseif last_buf and vim.api.nvim_buf_is_valid(last_buf) then
      vim.api.nvim_set_current_buf(last_buf)
    else
      -- Fallback: Switch to any valid non-terminal buffer
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if is_real_buffer(buf) and vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_set_current_win(win)
          vim.api.nvim_set_current_buf(buf)
          last_buf = buf
          last_win = win
          break
        end
      end
    end
  end)
end

M.open_terminal = open_terminal
M.toggle_terminal = toggle_terminal
M.close_terminal_callback = close_terminal_callback

return M
