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
    border = true, -- virtual line above/below so headings get breathing room
    border_virtual = true, -- borders never consume real buffer lines
    left_pad = 1,
    right_pad = 2,
  },
  code = {
    style = "full", -- language icon + name above block, background behind
    width = "block",
    border = "thick",
    left_pad = 2,
    right_pad = 2,
  },
  bullet = {
    icons = { "●", "○", "◆", "◇" },
    left_pad = 0,
    right_pad = 1,
  },
  dash = {
    width = 60,
  },
  pipe_table = {
    -- GFM tables have no separator between body rows and the plugin offers
    -- none, so lean on heavier column lines and wider cells to tell rows apart.
    preset = "heavy",
    padding = 2,
  },
  checkbox = {
    unchecked = { icon = "󰄱 " },
    checked = { icon = "󰱒 " },
  },
})
