vim.api.nvim_set_keymap('n', '<S-T>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
require("nvim-tree").setup()
