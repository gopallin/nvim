-- trouble.lua
local status, mason = pcall(require, "trouble")
if not status then
 vim.notify("trouble not found")
 return
end

trouble.setup({
 auto_preview = true, -- Automatically opens a preview window
                use_diagnostic_signs = true, -- Uses diagnostic signs in the gutter
		modes = {
      preview_float = {
      mode = "diagnostics",
      preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
      },
    },
  },
})

