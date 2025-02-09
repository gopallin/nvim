local M = {}

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

M.toggle_left_diff_pane = toggle_left_diff_pane

return M
