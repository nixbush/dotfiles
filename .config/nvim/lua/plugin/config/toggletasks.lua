local M = {}

M.init = function()
   local map = vim.keymap.set
   map('n', '<leader>te', ':Telescope toggletasks edit<cr>', { silent = true })
   map(
      'n',
      '<leader>ts',
      ':Telescope toggletasks select<cr>',
      { silent = true }
   )
   map('n', '<leader>tt', ':Telescope toggletasks spawn<cr>', { silent = true })
end

M.config = function()
   require('toggletasks').setup()
   require('telescope').load_extension 'toggletasks'
end

return M
