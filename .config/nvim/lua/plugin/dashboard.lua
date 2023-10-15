return {
   'nvimdev/dashboard-nvim',
   enabled = function()
      return vim.fn.argc() == 0
   end,
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   opts = {
      theme = 'hyper',
      config = {
         week_header = {
            enable = true,
         },
      },
   },
   config = true,
   event = 'VimEnter',
}
