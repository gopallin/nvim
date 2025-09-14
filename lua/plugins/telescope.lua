local status, telescope = pcall(require, "telescope")
if not status then
  vim.notify("telescope not found")
  return
end

local function yank_selection(prompt_bufnr)
  local selection = require("telescope.actions.state").get_selected_entry()
  if selection and selection.text then
    local message = selection.text
    if type(message) == 'string' then
      vim.fn.setreg("+", message)
      vim.notify("Error message copied to clipboard", vim.log.levels.INFO)
      require('telescope.actions').close(prompt_bufnr)
    else
      vim.notify("Could not get text to copy from selection.", vim.log.levels.ERROR)
    end
  else
    vim.notify("No selection or text field found.", vim.log.levels.ERROR)
  end
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
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-y>"] = yank_selection,
      },
      n = {
        ["<C-y>"] = yank_selection,
      },
    },
  },
})
