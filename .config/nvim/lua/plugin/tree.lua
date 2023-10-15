return {
   'nvim-tree/nvim-tree.lua',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   opts = {},
   config = true,
   event = 'VeryLazy',
   keys = {
      {
         '<localleader>e',
         '<cmd>NvimTreeToggle<cr>',
         desc = 'Open File Explorer',
      },
   },
}
