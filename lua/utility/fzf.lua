local M = {}

local fzf = require("fzf-lua")
local diagnostics = vim.diagnostic

function M.files()
  fzf.files()
end

function M.live_grep()
  fzf.live_grep()
end

function M.buffers()
  fzf.buffers()
end

function M.help_tags()
  fzf.help_tags()
end

function M.lsp_implementations()
  fzf.lsp_implementations()
end

function M.git_commits()
  fzf.git_commits()
end

function M.git_status()
  fzf.git_status()
end

-- Custom function to display diagnostics in the current file
function M.show_diagnostics_in_fzf()
  -- Get diagnostics for the current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  local diags = diagnostics.get(bufnr)

  if #diags == 0 then
    vim.notify("No diagnostics in the current file!", vim.log.levels.INFO)
    return
  end

  -- Format diagnostics for fzf
  local entries = {}
  for _, diag in ipairs(diags) do
    local line = diag.lnum + 1 -- Convert to 1-based index
    local msg = diag.message:gsub("\n", " ") -- Replace newlines with spaces
    table.insert(entries, string.format("%d: %s", line, msg))
  end

  -- Pass entries to fzf-lua
  fzf.fzf_exec(entries, {
    prompt = "Diagnostics> ",
    previewer = false,
    actions = {
      ["default"] = function(selected)
        local line = tonumber(selected[1]:match("^(%d+):"))
        if line then
          vim.api.nvim_win_set_cursor(0, { line, 0 })
        end
      end,
      ["ctrl-y"] = function(selected)
        local msg = selected[1]:match(":%s(.+)$")
        if msg then
          vim.fn.setreg("+", msg)  -- Copy to the system clipboard
          vim.notify("Error message copied to clipboard", vim.log.levels.INFO)
        else
          vim.notify("Failed to copy the error message", vim.log.levels.ERROR)
        end
      end,
    },
  })
end

local blame_win = nil -- Store the floating window ID

function M.show_git_blame()
  -- Close any existing floating window first
  if blame_win and vim.api.nvim_win_is_valid(blame_win) then
    vim.api.nvim_win_close(blame_win, true)
  end

  -- Get the full path of the current buffer
  local file = vim.fn.expand('%:p')
  if file == "" or vim.fn.filereadable(file) == 0 then
    return
  end

  -- Ignore buffers like NvimTree
  if vim.bo.filetype == "NvimTree" then
    return
  end

  local line_number = vim.fn.line('.')
  local blame_cmd = string.format('git blame -L %d,%d --porcelain -- %s', line_number, line_number, file)
  local blame_output = vim.fn.systemlist(blame_cmd)

  if not blame_output or #blame_output == 0 then
    return
  end

  -- Extract commit hash
  local commit_hash = string.match(blame_output[1], "^%w+")
  if not commit_hash then
    return
  end

  -- Handle uncommitted changes
  local message
  if commit_hash:match("^0+$") then
    message = "uncommitted changes"
  else
    message = vim.fn.system('git show -s --format="%an | %s | %h | %ai" ' .. commit_hash)
    message = message:gsub("%s+$", "") -- Trim whitespace
  end

  -- Display message in a floating window
  local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { message })

  -- Get cursor position
  local win_width = vim.api.nvim_get_option("columns")
  local opts = {
    relative = "editor",
    row = 1,
    col = vim.o.columns - win_width - 2,
    width = win_width,
    height = 1,
    style = "minimal",
    border = nil,
  }

  blame_win = vim.api.nvim_open_win(buf, false, opts)

  -- Close floating window when the cursor moves
  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      if blame_win and vim.api.nvim_win_is_valid(blame_win) then
        vim.api.nvim_win_close(blame_win, true)
        blame_win = nil
      end
    end,
    once = true
  })
end

return M
