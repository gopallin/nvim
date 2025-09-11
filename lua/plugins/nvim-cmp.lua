-- Using pcall to safely load the nvim-cmp plugin with lazy.nvim
local status, cmp = pcall(require, "cmp")
local status_lspconfig, lspconfig = pcall(require, "lspconfig")

if not status then
   vim.notify("nvim-cmp not found", vim.log.levels.ERROR)
		return
end

if not status_lspconfig then
  vim.notify("nvim lspconfig not found")
  return
end

-- Setup nvim-cmp
cmp.setup({
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<C-d>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  -- Autocompletion sources
  sources = {
    { name = 'nvim_lsp' },    -- LSP source for completion
    { name = 'buffer' },      -- Completion from buffer text
    { name = 'path' },        -- Completion for file paths
    { name = 'luasnip' },     -- Snippets support
  },

  -- Snippet expansion (using LuaSnip)
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})


