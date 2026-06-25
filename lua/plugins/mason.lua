-- mason.lua
local watchfiles = require('vim.lsp._watchfiles')
local glob = vim.glob

watchfiles._poll_exclude_pattern = watchfiles._poll_exclude_pattern
  + glob.to_lpeg('**/private/var/folders/**')
  + glob.to_lpeg((vim.env.TMPDIR or '') .. '**')

local mason_status, mason = pcall(require, "mason")
if not mason_status then
  vim.notify("mason not found")
  return
end

local mlsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_status then
  vim.notify("mason-lspconfig not found")
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration = false,
  exclude = { "**/.git/**", "**/private/**" },
}

local servers = { "lua_ls", "intelephense" }

-- Setup mason
mason.setup()

-- mason-lspconfig v2 dropped the `handlers` option; capabilities are now applied
-- through Neovim's native LSP config and servers are auto-enabled by the plugin.
vim.lsp.config("*", { capabilities = capabilities })

mason_lspconfig.setup({
  ensure_installed = servers,
})
