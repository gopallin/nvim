local status, nvim_tree = pcall(require, "nvim-tree")

if not status then
	vim.notify("nvim-tree not found")
	return
end

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Key mappings for nvim-tree
--  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  --vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy"))
  --vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
end
local keybindings = require("config.keybindings")
nvim_tree.setup({
    on_attach = keybindings.setup_nvim_tree_keymaps,
		sort_by = "case_sensitive",
  git = {
		enable = true,
  },
  filters = {
		dotfiles = true,
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

