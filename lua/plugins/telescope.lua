
local status, telescope = pcall(require, "telescope")
if not status then
	vim.notify("telescope not found")
	return
end

require('telescope').setup{
    defaults = {
        file_ignore_patterns = {}, -- Ensure .env isn't ignored
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        hidden = true,             -- Include hidden files in the search
    }
}

