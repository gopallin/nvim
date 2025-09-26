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

local util_status, util = pcall(require, "lspconfig.util")
if not util_status then
	vim.notify("lspconfig.util not found")
	return
end

local mlsp_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_status then
	vim.notify("mason-lspconfig not found")
	return
end

-- Setup mason
mason.setup()

local servers = { "lua_ls", "intelephense" }

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
if capabilities.workspace then
  capabilities.workspace.didChangeWatchedFiles = nil
end

for _, server_name in ipairs(servers) do
	lspconfig[server_name].setup({
		capabilities = capabilities,
		root_dir = function(fname)
			if fname:find("/private/var/folders/", 1, true) then
				return nil
			end
			return util.root_pattern(".git", "lua")(fname)
		end,
	})
end
