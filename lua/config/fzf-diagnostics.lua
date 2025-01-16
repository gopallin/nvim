-- Ensure this is added to your Neovim config (e.g., ~/.config/nvim/lua/config/fzf_diagnostics.lua)
local M = {}

local fzf = require("fzf-lua")
local diagnostics = vim.diagnostic

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

return M

