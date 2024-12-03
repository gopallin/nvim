-- diffview.lua
local status, mason = pcall(require, "diffview")
if not status then
 vim.notify("diffview not found")
 return
end

diffview.setup()

