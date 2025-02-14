local status, diffview = pcall(require, "diffview")
if not status then
 vim.notify("diffview not found")
 return
end

local diffviewUtility = require('utility.diffview')

diffview.setup({
	keymaps = {
    view = {
      ["<leader>e"] = "<cmd>DiffviewToggleFiles<CR>",
      ["<leader>z"] = diffviewUtility.toggle_left_diff_pane,
    },
    file_panel = {
      ["<leader>e"] = "<cmd>DiffviewToggleFiles<CR>",
      ["<leader>z"] = diffviewUtility.toggle_left_diff_pane,
    },
  },
	hooks = {
		diff_buf_read = function(bufnr)
			-- Change local options in diff buffers
			vim.opt_local.wrap = false
			vim.opt_local.list = false
			vim.opt_local.colorcolumn = { 80 }
		end,
		view_opened = function(view)
			print(
				("A new %s was opened on tab page %d!")
				:format(view.class:name(), view.tabpage)
			)
		end,
	}
})

