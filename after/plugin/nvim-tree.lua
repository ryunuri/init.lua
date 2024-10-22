-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Global key mapping to open nvim-tree in a new tab
vim.keymap.set("n", "<leader>e", function ()
    require("nvim-tree.api").tree.toggle()
end, { desc = "Open Nvim Tree with vertical split" })

-- empty setup using defaults
require("nvim-tree").setup()
