-- Ignore /private directory for file watching to prevent EPERM errors on macOS
vim.g.watch_exclusions = { '*/private/*' }

local function load_files(path, files)
	for _, file in ipairs(files) do
		require(path .. '.' .. file)
	end
end

load_files('config', {
  'options',
})

load_files('plugins', {
  'lazy',
  'lualine',
  'nvim-tree',
  'mason',
  'nvim-cmp',
  'bufferline',
  'diffview',
  'formatter',
  'fzf-lua',
  'indent-blankline',
  'telescope',
})

load_files('config', {
  'keybindings',
  'autocmds',
  'styles',
})
