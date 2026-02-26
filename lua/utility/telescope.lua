local M = {}

local blame_win = nil -- Store the floating window ID

function M.show_git_blame()
  -- Close any existing floating window first
  if blame_win and vim.api.nvim_win_is_valid(blame_win) then
    vim.api.nvim_win_close(blame_win, true)
  end

  -- Get the full path of the current buffer
  local file = vim.fn.expand('%:p')
  if file == "" or vim.fn.filereadable(file) == 0 then
    vim.notify("No valid file detected!", vim.log.levels.WARN)
    return
  end

  -- Ignore buffers like NvimTree
  if vim.bo.filetype == "NvimTree" then
    return
  end

  local line_number = vim.fn.line('.')
  local blame_cmd = string.format('git blame -L %d,%d --porcelain -- %s', line_number, line_number, vim.fn.shellescape(file))
  local blame_output = vim.fn.systemlist(blame_cmd)

  -- Handle Git command errors
  if not blame_output or #blame_output == 0 or blame_output[1]:match("^fatal:") then
    vim.notify("Git Blame Error: File is not tracked or does not exist in HEAD")
    return
  end

  -- Extract commit hash
  local commit_hash = string.match(blame_output[1], "^%w+")
  if not commit_hash then
    vim.notify("No commit hash found", vim.log.levels.WARN)
    return
  end

  -- Handle uncommitted changes
  local message
  if commit_hash:match("^0+$") then
    message = "uncommitted changes"
  else
    message = vim.fn.system('git show -s --format="%an | %s | %h | %ai" ' .. commit_hash)
    if message:match("^fatal:") then
      message = "Git command error: " .. message:gsub("%s+$", "") -- Trim whitespace
    else
      message = message:gsub("%s+$", "") -- Trim whitespace
    end
  end

  -- Display message in a floating window
  local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer

  -- Split message into lines to avoid newlines within an item
  local message_lines = vim.split(message, "\n", { plain = true })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, message_lines)

  -- Get cursor position
  local win_width = math.max(30, #message + 2) -- Minimum width of 30
  local max_width = vim.o.columns -- Get the total width of Neovim
  local opts = {
    relative = "editor",
    row = 1,
    col = max_width - win_width,
    width = win_width,
    height = #message_lines, -- set height based on number of lines
    style = "minimal",
    border = "rounded",
  }

  blame_win = vim.api.nvim_open_win(buf, false, opts)
end

function M.clear_git_blame()
  if blame_win and vim.api.nvim_win_is_valid(blame_win) then
    vim.api.nvim_win_close(blame_win, true)
    blame_win = nil
  end
end

return M
