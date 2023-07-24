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
   git = {
      ignore = false,
   }
}
