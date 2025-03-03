local function load_files(path, files)
	for _, file in ipairs(files) do
			require(path .. "." .. file)
	end
end

load_files("config", {
    "options",
})

load_files("plugins", {
    "lazy",
    "lualine",
    "nvim-tree",
    "mason",
    "nvim-cmp",
    "bufferline",
    "diffview",
    "formatter",
    "fzf-lua",
})

load_files("config", {
		"keybindings",
		"autocmds",
		"styles",
})
