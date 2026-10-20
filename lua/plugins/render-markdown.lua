local status, render_markdown = pcall(require, "render-markdown")
if not status then
  vim.notify("render-markdown not found")
  return
end

render_markdown.setup({
  file_types = { "markdown" },
  -- "rendered" view in normal/visual mode; cursor line always shows raw markdown
  render_modes = { "n", "c", "t" },
  heading = {
    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
  },
  code = {
    style = "full", -- language icon + name above block, background behind
    width = "block",
    left_pad = 1,
    right_pad = 1,
  },
  checkbox = {
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },
})
