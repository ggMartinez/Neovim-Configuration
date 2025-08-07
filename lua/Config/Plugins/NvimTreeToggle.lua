vim.api.nvim_set_keymap('n', '<S-T>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-R>', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

require("nvim-tree").setup({
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
})
