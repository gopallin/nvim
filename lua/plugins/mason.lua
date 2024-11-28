-- mason.lua
local mason_status, mason = pcall(require, "mason")
if not mason_status then
 vim.notify("mason not found")
 return
end

local nlsp_status, nvim_lsp = pcall(require, "lspconfig")
if not nlsp_status then
 vim.notify("lspconfig not found")
 return
end

local mlsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_status then
 vim.notify("mason-lspconfig not found")
 return
end


mason.setup()
mason_lspconfig.setup({})

