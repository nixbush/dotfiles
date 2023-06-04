local map = vim.keymap.set
map('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>')
map('n', '<leader>fg', '<cmd>Telescope git_files hidden=true<cr>')
map('n', '<leader>fs', '<cmd>Telescope live_grep hidden=true<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fm', '<cmd>Telescope keymaps<cr>')
map('n', '<leader>fd', '<cmd>Telescope diagnostics bufnr=0<cr>')
map('n', '<leader>fD', '<cmd>Telescope diagnostics<cr>')

local actions = require 'telescope.actions'
require('telescope').setup {
   defaults = {
      borderchars = {
         '─',
         '│',
         '─',
         '│',
         '┌',
         '┐',
         '┘',
         '└',
      },
      mappings = {
         i = {
            ['<Esc>'] = actions.close,
            ['<A-q>'] = actions.close,
         },
         n = {
            ['<Esc>'] = actions.close,
            ['<A-q>'] = actions.close,
         },
      },
      file_ignore_patterns = {
         'build/.*',
         'bin/.*',
         'lib/.*',
         '.git/.*',
         'target/.*',
      },
   },
   --[[extensions = {
      fzf = {
         fuzzy = true,
         override_generic_sorter = false,
         override_file_sorter = true,
         case_mode = 'smart_case',
      },
   },]]
}
