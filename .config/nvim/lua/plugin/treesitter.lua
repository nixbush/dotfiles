return {
   'nvim-treesitter/nvim-treesitter',
   build = ':TSUpdate',
   event = 'VeryLazy',
   config = function()
      require('nvim-treesitter.configs').setup {
         ensure_installed = { 'c', 'cpp', 'lua', 'racket' },
         sync_install = false,
         highlight = {
            enable = true,
         },
         indent = {
            enable = true,
         },
         incremental_selection = {
            enable = true,
            keymaps = {
               init_selection = 'gnn', -- set to `false` to disable one of the mappings
               node_incremental = 'grn',
               scope_incremental = 'grc',
               node_decremental = 'grm',
            },
         },
      }
      vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
         group = vim.api.nvim_create_augroup('TreesitterWorkaround', {}),
         callback = function()
            vim.opt.foldmethod     = 'expr'
            vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
         end
      })
   end,
}
