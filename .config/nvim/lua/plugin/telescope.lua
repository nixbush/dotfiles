local spec = {
   'nvim-telescope/telescope.nvim',
   dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
   },
   cmd = { 'Telescope' },
   config = true,
}

spec.opts = {
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
      file_ignore_patterns = {
         'build/.*',
         'bin/.*',
         'lib/.*',
         '.git/.*',
         'target/.*',
      },
   },
}

spec.keys = {
   {
      '<leader>ff',
      '<cmd>Telescope find_files hidden=true<cr>',
      desc = 'Find files',
   },
   {
      '<leader>fg',
      '<cmd>Telescope git_files hidden=true<cr>',
      desc = 'Find files (Git)',
   },
   {
      '<leader>fs',
      '<cmd>Telescope live_grep hidden=true<cr>',
      desc = 'Grep string',
   },
   {
      '<leader>fh',
      '<cmd>Telescope help_tags<cr>',
      desc = 'Find Help',
   },
   {
      '<leader>fb',
      '<cmd>Telescope buffers<cr>',
      desc = 'Find buffer',
   },
   {
      '<leader>fm',
      '<cmd>Telescope keymaps<cr>',
      desc = 'Find keymap',
   },
   {
      '<leader>fd',
      '<cmd>Telescope diagnostics bufnr=0<cr>',
      desc = 'Find local diagnostics',
   },
   {
      '<leader>fD',
      '<cmd>Telescope diagnostics<cr>',
      desc = 'Find project diagnostics',
   },
}

return spec
