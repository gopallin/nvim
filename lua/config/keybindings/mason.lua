local M = {}

local lsp_references_open = false

local function toggle_lsp_references()
  if lsp_references_open then
    -- Close the window if it's already open
    vim.cmd("cclose")
    lsp_references_open = false
  else
    -- Show LSP references and set the flag to open
    vim.lsp.buf.references()
    lsp_references_open = true
  end
end

M.toggle_lsp_references = toggle_lsp_references

return M
