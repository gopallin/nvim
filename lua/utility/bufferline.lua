local bufferline_config = require('plugins.bufferline') -- Adjust path to your bufferline.lua
local bufferline = require('bufferline')

local M = {}

local function jump_to_last_buffer()
  local last_buffer_index = #vim.fn.getbufinfo({ buflisted = true })
  vim.cmd("BufferLineGoToBuffer " .. last_buffer_index)
  vim.notify("Goes to buffer " .. last_buffer_index)
end

local function switch_to_previous_buffer()
  local buffers = vim.fn.getbufinfo({ buflisted = true }) -- Get all listed buffers
  if #buffers > 1 then
    vim.cmd("b#") -- Switch to the previous buffer
  else
    vim.notify("No previous buffer available", vim.log.levels.INFO)
  end
end

local function close_others_in_group()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_buftype = vim.api.nvim_buf_get_option(current_buf, "buftype")
    local is_terminal = current_buftype == "terminal"

    -- Get all buffers from bufferline
    local buffers = bufferline.get_elements().elements

    for _, buf in ipairs(buffers) do
        local buf_id = buf.id
        if buf_id ~= current_buf then -- Skip the current buffer
            local buf_buftype = vim.api.nvim_buf_get_option(buf_id, "buftype")
            local in_same_group = (is_terminal and buf_buftype == "terminal") or
                                 (not is_terminal and buf_buftype ~= "terminal")
            if in_same_group then
                vim.api.nvim_buf_delete(buf_id, { force = true })
            end
        end
    end
end

local function toggle_terminal_buffers()
    _G.show_terminals = not _G.show_terminals
    bufferline_config.configure_bufferline()
    vim.cmd('redrawtabline')
    vim.notify("Terminal buffers " .. (_G.show_terminals and "shown" or "hidden"))
end

local function close_current_buffer()
    local current_buf = vim.api.nvim_get_current_buf() -- Store current buffer
    switch_to_previous_buffer()
    vim.api.nvim_buf_delete(current_buf, { force = true }) -- Close stored buffer
end

local function jump_to_buffer_at(position)
  local buffers = bufferline.get_elements().elements
  local target = buffers[position]
  if target then
    vim.api.nvim_set_current_buf(target.id)
    vim.notify("Goes to buffer " .. position)
  end
end

M.jump_to_last_buffer = jump_to_last_buffer
M.switch_to_previous_buffer = switch_to_previous_buffer
M.close_others_in_group = close_others_in_group
M.toggle_terminal_buffers = toggle_terminal_buffers
M.close_current_buffer = close_current_buffer
M.jump_to_buffer_at = jump_to_buffer_at

return M
