-- 初始化插件設定
local function load_files(path, files)
	for _, file in ipairs(files) do
			require(path .. "." .. file)
	end
end

-- 插件設定
load_files("plugins", {
    "lazy",           -- Lazy.nvim 的配置
    "lualine",        -- lualine 狀態列
    "nvim-tree",      -- 文件樹
    "mason",          -- LSP 管理
    "nvim-cmp",
    "bufferline",
    "diffview",
    "formatter",
    "fzf-lua",
})

-- 全域設定
load_files("config", {
    "options",        -- 編輯器選項
    "keybindings",    -- 快捷鍵綁定
})
