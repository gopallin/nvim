local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons'},

  -- diffview.nvim
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- nvim-tree.lua
  {
    "kyazdani42/nvim-tree.lua",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- mason.nvim and LSP
  {
    "williamboman/mason.nvim",
  },
  { "williamboman/mason-lspconfig.nvim", dependencies = "neovim/nvim-lspconfig" },

  -- nvim-cmp and snippets
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline" },
  { "saadparwaiz1/cmp_luasnip" },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
})
