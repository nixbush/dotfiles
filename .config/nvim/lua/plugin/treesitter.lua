local ft = { 'c', 'cpp', 'lua', 'bash' }

return {
   'nvim-treesitter/nvim-treesitter',
   config = function()
      require('nvim-treesitter.configs').setup {
         ensure_installed = ft,
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
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.wo.foldenable = false
   end,
   build = ':TSUpdate',
   ft = ft,
}
