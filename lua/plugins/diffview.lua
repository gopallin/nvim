-- diffview.lua
local diffview_status, mason = pcall(require, "mason")
if not diffview_status then
 vim.notify("diffview not found")
 return
end

diffview.setup()

