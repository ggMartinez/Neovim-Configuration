vim.api.nvim_create_user_command(
  'Reindent',
  function()
    vim.cmd('normal! gg=G')
    vim.cmd('retab')
  end,
  {}
)

