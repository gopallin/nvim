local status, nvim_tree = pcall(require, "nvim-tree")

if not status then
	vim.notify("nvim-tree not found")
	return
end

nvim_tree.setup({
  sort_by = "case_sensitive",
	git = {
		enable = true,
	},
	filters = {
		dotfiles = true,
		custom = { "node_modules" },
	},
  view = {
	side = "right",
	number = false,
	relativenumber = false,
	signcolumn = "no",
	width = 30,
  },
  renderer = {
    group_empty = true,
	icons = {
		show = {
				folder_arrow = true,
				file = true,
				folder = true,
		},
	},
  },
})

