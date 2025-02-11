-- mason.lua
local mason_status, mason = pcall(require, "mason")
if not mason_status then
 vim.notify("mason not found")
 return
end

local nlsp_status, lspconfig = pcall(require, "lspconfig")
if not nlsp_status then
 vim.notify("lspconfig not found")
 return
end

local mlsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_status then
 vim.notify("mason-lspconfig not found")
 return
end

-- Setup mason
mason.setup()

-- Setup mason-lspconfig
mason_lspconfig.setup({
  ensure_installed = { "lua_ls", "ts_ls", "pyright", "rust_analyzer" },
  automatic_installation = true,
})

-- Test lspconfig directly
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})
