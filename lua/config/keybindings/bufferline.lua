local M = {}

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

M.jump_to_last_buffer = jump_to_last_buffer
M.switch_to_previous_buffer = switch_to_previous_buffer

return M
