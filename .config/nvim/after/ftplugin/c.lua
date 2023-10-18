vim.cmd 'compiler gcc'
vim.api.nvim_buf_set_option(0, 'makeprg', 'cmake --build build')

vim.keymap.set('n', '<F5>', function()
   vim.cmd 'make'
   if not vim.v.shell_error then
      require('utils.qflist').toggle_quickfix()
   end
end)
