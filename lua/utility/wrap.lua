local M = {}

M.pairs = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ['"'] = '"',
  ["'"] = "'",
}

function M.wrap_selection(open)
  local close = M.pairs[open]
  if not close then return end
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
  vim.cmd('normal! `>a' .. close)
  vim.cmd('normal! `<i' .. open)
end

return M

