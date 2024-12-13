local status, nvim_tree = pcall(require, "nvim-tree")

if not status then
	vim.notify("nvim-tree not found")
	return
end

local keybindings = require("config.keybindings")

nvim_tree.setup({
  on_attach = keybindings.setup_nvim_tree_keymaps,
		sort_by = "case_sensitive",
  git = {
		enable = true,
  },
  filters = {
		dotfiles = false,
  },
  view = {
    side = "left",
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

