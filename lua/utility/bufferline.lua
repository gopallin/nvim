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

local function close_all_buffers_except_current()
  local current_buf = vim.api.nvim_get_current_buf()
  -- Loop over all buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    -- Only delete if it's not the current buffer and it is listed.
    if buf ~= current_buf and vim.fn.buflisted(buf) == 1 then
      -- Use silent! to avoid error messages if deletion fails.
      vim.cmd("silent! bdelete " .. buf)
    end
  end
end

M.jump_to_last_buffer = jump_to_last_buffer
M.switch_to_previous_buffer = switch_to_previous_buffer
M.close_all_buffers_except_current = close_all_buffers_except_current

return M
