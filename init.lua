    local config_dir = vim.fn.stdpath('config') .. '/lua/config'
    local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'

    for _, file in ipairs(vim.fn.readdir(plugins_dir)) do
        if file:match("%.lua$") then
            local module_name = file:gsub("%.lua$", "")
            require("plugins." .. module_name)
        end
    end

    for _, file in ipairs(vim.fn.readdir(config_dir)) do
        if file:match("%.lua$") then
            local module_name = file:gsub("%.lua$", "")
            require("config." .. module_name)
        end
    end

