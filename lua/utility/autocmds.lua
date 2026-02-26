local M = {}
local cursor_focus_ns = vim.api.nvim_create_namespace("cursor_focus_flash")
local last_line_by_win = {}

function M.flash_cursor_line()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)

  if vim.bo[buf].buftype ~= "" then
    return
  end

  vim.api.nvim_buf_clear_namespace(buf, cursor_focus_ns, 0, -1)
  local line = vim.api.nvim_win_get_cursor(win)[1] - 1
  vim.api.nvim_buf_add_highlight(buf, cursor_focus_ns, "IncSearch", line, 0, -1)

  vim.defer_fn(function()
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_clear_namespace(buf, cursor_focus_ns, 0, -1)
    end
  end, 150)
end

function M.flash_cursor_line_on_line_change()
  local win = vim.api.nvim_get_current_win()
  local current_line = vim.api.nvim_win_get_cursor(win)[1]
  local previous_line = last_line_by_win[win]

  last_line_by_win[win] = current_line
  if previous_line == nil or previous_line == current_line then
    return
  end

  M.flash_cursor_line()
end

return M
