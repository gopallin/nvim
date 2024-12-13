-- diffview.lua
local status, diffview = pcall(require, "diffview")
if not status then
 vim.notify("diffview not found")
 return
end

diffview.setup({
	keymaps = {
    view = {
      ["<leader>e"] = "<cmd>DiffviewToggleFiles<CR>",
    },
    file_panel = {
      ["<leader>e"] = "<cmd>DiffviewToggleFiles<CR>",
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

