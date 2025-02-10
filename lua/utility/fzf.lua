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

function M.show_git_blame()
  -- Get the current file relative to the working directory
  local file = vim.fn.expand('%')
  if file == "" then
    return
  end

  local line_number = vim.fn.line('.')
  -- Build the git blame command including the file name
  local blame_cmd = string.format('git blame -L %d,%d --porcelain %s', line_number, line_number, file)
  local blame_output = vim.fn.systemlist(blame_cmd)

  if not blame_output or #blame_output == 0 then
    return
  end

  -- Extract the commit hash from the first line of the blame output
  local commit_hash = string.match(blame_output[1], "^%w+")
  if not commit_hash then
    return
  end

  -- If the commit hash is composed entirely of zeros,
  -- consider the line as uncommitted
  if commit_hash:match("^0+$") then
    vim.api.nvim_echo({{"uncommitted changes", "Normal"}}, false, {})
    return
  end

  -- Retrieve the commit details (subject, author name, and relative commit time)
  local commit_details = vim.fn.system('git show -s --format="%an | %s | %ai" ' .. commit_hash)
  if commit_details and #commit_details > 0 then
    -- Trim any trailing newline characters
    commit_details = commit_details:gsub("%s+$", "")
    -- Display the commit details in the command line
    vim.api.nvim_echo({{commit_details, 'Normal'}}, false, {})
  end
end

return M

