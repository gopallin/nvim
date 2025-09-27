-- mason.lua
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
if capabilities.workspace then
  capabilities.workspace.didChangeWatchedFiles = nil
end

local servers = { "lua_ls", "intelephense" }

-- Setup mason
mason.setup()

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        root_dir = function(fname)
          local util = require("lspconfig.util")
          if fname:find("/private/var/folders/", 1, true) then
            return nil
          end
          return util.root_pattern(".git", "lua")(fname)
        end,
      })
    end,
  },
})