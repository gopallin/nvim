local status, bufferline = pcall(require, "bufferline")
if not status then
	vim.notify("bufferline not found")
	return
end

bufferline.setup({
  options = {
    truncate_names = false,
    mode = "buffers", -- Show buffers instead of tabs
    numbers = "ordinal",
    right_mouse_command = "bdelete! %d", -- Right-click to close
    left_mouse_command = "buffer %d", -- Left-click to navigate
    middle_mouse_command = nil, -- Middle-click does nothing
    indicator = {
      icon = "▎", -- Icon shown in the tabline
    },
    diagnostics = "nvim_lsp", -- Optional: Show diagnostics
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
    },
    always_show_bufferline = true, -- Always show the bufferline
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant", -- Separator style
    groups = {
      options = {
          toggle_hidden_on_enter = true, -- Reopen hidden groups when entering
      },
      items = {
        {
          name = "Terminals", -- Group name for terminals
          priority = 2, -- Lower priority appears after Files
          matcher = function(buf)
              -- Use buffer ID to check if it's a terminal
              local buftype = vim.api.nvim_buf_get_option(buf.id, "buftype")
              return buftype == "terminal"
          end,
        },
        {
          name = "Files", -- Group name for general files
          priority = 1, -- Higher priority appears first
          matcher = function(buf)
              -- Use buffer ID to check if it's not a terminal
              local buftype = vim.api.nvim_buf_get_option(buf.id, "buftype")
              return buftype ~= "terminal"
          end,
        },
      },
    },
  },
})
