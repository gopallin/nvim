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

local servers = { "lua_ls" }

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

for _, server_name in ipairs(servers) do
  lspconfig[server_name].setup({})
end
