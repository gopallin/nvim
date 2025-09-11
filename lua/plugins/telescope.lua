local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found")
  return
end

telescope.setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
      preview_cutoff = 1,
    },
    sorting_strategy = "ascending",
    sorter = require("telescope.sorters").get_fuzzy_file(),
    case_mode = "smart_case",
  },
})
