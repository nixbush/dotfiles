local M = {}

M.init = function()
   local map = vim.keymap.set
   map('n', '<leader>hh', require('harpoon.mark').add_file)
   map('n', '<leader>ht', ':Telescope harpoon marks<cr>')
   map('n', '<leader>hu', require('harpoon.ui').toggle_quick_menu)
   map('n', '<leader>hn', require('harpoon.ui').nav_next)
   map('n', '<leader>hp', require('harpoon.ui').nav_prev)
end

M.config = function()
   require('harpoon').setup()
   require('telescope').load_extension 'harpoon'
end

return M
