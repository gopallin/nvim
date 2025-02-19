local status, formatter = pcall(require, 'formatter')

if not status then
 vim.notify("formatter not found")
 return
end

formatter.setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
      -- Remove trailing whitespace without 'sed'
      -- require("formatter.filetypes.any").substitute_trailing_whitespace,
    }
  },
})
