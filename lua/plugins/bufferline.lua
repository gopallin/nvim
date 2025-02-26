local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("bufferline not found")
  return
end

_G.show_terminals = _G.show_terminals or false

-- Combined setup and toggle function
local function configure_bufferline()
  bufferline.setup({
  options = {
    truncate_names = false,
    mode = "buffers",
    numbers = "ordinal",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
        icon = "▎",
    },
    diagnostics = "nvim_lsp",
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", text_align = "center" },
    },
    always_show_bufferline = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
    custom_filter = function(buf)
      local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
      return _G.show_terminals or buftype ~= "terminal"
    end,
    groups = {
      options = {
          toggle_hidden_on_enter = true,
      },
      items = {
        {
          name = "Terminals",
          priority = 2,
          matcher = function(buf)
            local buftype = vim.api.nvim_buf_get_option(buf.id, "buftype")
            return buftype == "terminal"
          end,
        },
        {
          name = "ht toggle terminal",
          priority = 1,
          matcher = function(buf)
            local buftype = vim.api.nvim_buf_get_option(buf.id, "buftype")
            return buftype ~= "terminal"
          end,
        },
      },
    },
},
})
end

-- Initial setup
configure_bufferline()

return {
    configure_bufferline = configure_bufferline
}
