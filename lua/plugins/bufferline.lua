local status, bufferline = pcall(require, "bufferline")
if not status then
	vim.notify("bufferline not found")
	return
end

require("bufferline").setup({
  options = {
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
    separator_style = "slant", -- Separator style
  },
  highlights = {
    buffer_selected = {
      fg = "#FFFFFF", -- Foreground color for selected buffer
      bg = "#44475A", -- Background color for selected buffer
      bold = true,    -- Make it bold
      italic = false, -- Optional: make it italic
    },
    fill = {
      bg = "#282A36", -- Background color for the bufferline
    },
  },
})

