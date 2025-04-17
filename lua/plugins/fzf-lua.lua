local status, fzf = pcall(require, "fzf-lua")
if not status then
	vim.notify("fzf not found")
	return
end


fzf.setup({
  git = {
    status = {
      cmd = "git status --short --untracked-files=all",
      actions = {
        ["default"] = function(selected)
          local file = selected[1]
          if file then
            -- Trim leading markers (e.g., " M "), tabs, or whitespace
            file = file:match("%s*[%w]+%s+(.-)%s*$")
            if file and #file > 0 then
              require('diffview').open(file)
            else
              vim.notify("Could not parse file name", vim.log.levels.ERROR)
            end
          else
            vim.notify("No file selected", vim.log.levels.ERROR)
          end
        end,
      },
    },
  },
	keymap = {
    builtin = {
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
  },
  fzf_opts = {
		['--exact'] = nil,
    ["--wrap"] = true,
  },
  grep = {
    rg_glob = true,
    -- first returned string is the new search query
    -- second returned string are (optional) additional rg flags
    -- @return string, string?
    rg_glob_fn = function(query, opts)
      local regex, flags = query:match("^(.-)%s%-%-(.*)$")
      -- If no separator is detected will return the original query
      return (regex or query), flags
    end,
  },
  winopts = {
    preview = {
      wrap = "wrap",
    },
  },
  defaults = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    formatter = "path.filename_first",
  },
})
