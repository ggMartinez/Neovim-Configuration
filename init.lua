require("plugins")

-- vim.cmd.colorscheme "catppuccin"
require('vscode').load('dark')

require("nvim-tree").setup()


vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'deus'
vim.g['airline#extensions#hunks#enabled'] = 1

require('gitsigns').setup()
require('Comment').setup()

vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

require("indent_blankline").setup {
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    show_trailing_blankline_indent = false,
}

vim.api.nvim_set_keymap('n', '<S-T>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })


vim.opt.mouse = ""
vim.opt.guicursor = ""


