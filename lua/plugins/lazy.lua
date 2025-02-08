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
  -- Global dependencies
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },

  -- Plugins
  { "akinsho/bufferline.nvim" },

  -- diffview.nvim
  { "sindrets/diffview.nvim" },

  -- nvim-tree.lua
  {
    "kyazdani42/nvim-tree.lua",
    event = "VimEnter",
  },

  -- lualine.nvim
  { "nvim-lualine/lualine.nvim" },

  -- mason.nvim and LSP
  { "williamboman/mason.nvim" },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  { "mhartington/formatter.nvim" },

  -- nvim-cmp and snippets
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline" },
  { "saadparwaiz1/cmp_luasnip" },

  { "ibhagwan/fzf-lua" },
})

