return {
   'nvim-telescope/telescope.nvim',
   dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
   },
   init = function()
      local map = vim.keymap.set
      map('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>')
      map('n', '<leader>fg', '<cmd>Telescope git_files hidden=true<cr>')
      map('n', '<leader>fs', '<cmd>Telescope live_grep hidden=true<cr>')
      map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
      map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
      map('n', '<leader>fm', '<cmd>Telescope keymaps<cr>')
      map('n', '<leader>fd', '<cmd>Telescope diagnostics bufnr=0<cr>')
      map('n', '<leader>fD', '<cmd>Telescope diagnostics<cr>')
   end,
   config = function()
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
            file_ignore_patterns = {
               'build/.*',
               'bin/.*',
               'lib/.*',
               '.git/.*',
               'target/.*',
            },
         },
      }
   end,
   cmd = { 'Telescope' },
   keys = {
      { '<leader>f', nil, desc = 'Telescope Actions' },
   },
}
