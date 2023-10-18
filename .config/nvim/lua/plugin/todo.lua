return {
   'folke/todo-comments.nvim',
   dependencies = { 'nvim-lua/plenary.nvim' },
   opts = {},
   event = 'VeryLazy',
   keys = {
      {
         '[t',
         '<cmd>lua require("todo-comments").jump_next()<cr>',
         desc = 'Next TODO comment',
      },
      {
         ']t',
         '<cmd>lua require("todo-comments").jump_prev()<cr>',
         desc = 'Prev TODO comment',
      },
      { '<localleader>t', ':TodoTelescope', desc = 'Search TODO comments' },
   },
}
