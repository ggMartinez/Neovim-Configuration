--vim.api.nvim_set_keymap('n', '<S-T>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-R>', ':NvimTreeFocus<CR>', { noremap = true, silent = true })


-- Track last non-tree window (create an augroup to avoid duplicate autocmds)
vim.api.nvim_create_augroup("MyNvimTreeFocus", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = "MyNvimTreeFocus",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ok, ft = pcall(vim.api.nvim_buf_get_option, bufnr, "filetype")
    ft = ft or ""
    -- adjust this if you use neo-tree or another file-explorer (e.g. "neo-tree")
    if ft ~= "NvimTree" then
      _G._nvimtree_last_non_tree_win = vim.api.nvim_get_current_win()
    end
  end,
})

-- Toggle focus function
_G.toggle_nvimtree_focus = function()
  local ok, api = pcall(require, "nvim-tree.api")
  if not ok then
    -- fallback if nvim-tree is not available
    vim.cmd("NvimTreeToggle")
    return
  end

  -- If we're in the nvim-tree buffer, try to return to the last saved window
  if vim.bo.filetype == "NvimTree" then
    local last = _G._nvimtree_last_non_tree_win
    if last and vim.api.nvim_win_is_valid(last) then
      vim.api.nvim_set_current_win(last)
      return
    end
    -- fallback: try previous window
    vim.cmd("wincmd p")
    return
  end

  -- We're in code: remember current window and focus/open the tree
  _G._nvimtree_last_non_tree_win = vim.api.nvim_get_current_win()

  if api.tree.is_visible() then
    api.tree.focus()
  else
    api.tree.open()
    -- small schedule guard to avoid rare race issues
    vim.schedule(function() api.tree.focus() end)
  end
end

-- your mapping (Shift+T)
vim.keymap.set("n", "<S-T>", _G.toggle_nvimtree_focus, { noremap = true, silent = true, desc = "Toggle focus: NvimTree <-> code" })

require("nvim-tree").setup({
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
})
