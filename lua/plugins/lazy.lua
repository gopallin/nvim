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
  rocks = {
    enabled = false,
  },
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

  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" }, event = "VimEnter" },

  { "lukas-reineke/indent-blankline.nvim" },

  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
      })

      vim.cmd('colorscheme github_dark')
    end,
  }
})

