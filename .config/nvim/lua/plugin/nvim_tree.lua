---------------------------------
-- Mappings
---------------------------------
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

---------------------------------
-- Configuration
---------------------------------
require('nvim-tree').setup {
   disable_netrw = true,
   hijack_cursor = true,
   view = {
      width = 30,
   },
   renderer = {
      icons = {

         glyphs = {
            git = {
               unstaged = '✗',
               staged = '✓',
               unmerged = '',
               renamed = '➜',
               untracked = '★',
               deleted = '',
               ignored = '',
            },
         },
      },
   },
   git = {
      ignore = false,
   },
}
