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
  },
  highlights = {
    -- Highlight for the selected buffer
    buffer_selected = {
      fg = "#FFFFFF", -- Text color for the selected buffer
      bg = "#99a3e0", -- Background color for the selected buffer
      bold = true,    -- Make the text bold
      italic = false, -- Disable italic
    },
    -- Highlight for unselected buffers
    buffer_visible = {
      fg = "#AAAAAA", -- Text color for visible but not selected buffers
      bg = "#3b3f51", -- Background color for unselected buffers
    },
    -- Highlight for the fill area in the bufferline
    fill = {
      bg = "#282A36", -- Background color for the bufferline fill
    },
    -- Highlight for the tab separator
    separator_selected = {
      fg = "#99a3e0", -- Same as `buffer_selected.bg` for seamless look
      bg = "#282A36", -- Match `fill.bg`
    },
    separator_visible = {
      fg = "#3b3f51", -- Same as `buffer_visible.bg`
      bg = "#282A36", -- Match `fill.bg`
    },
  },
})

