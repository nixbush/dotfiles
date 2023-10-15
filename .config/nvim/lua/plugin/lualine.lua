return {
   'nvim-lualine/lualine.nvim',
   lazy = false,
   opts = {
      options = {
         theme = 'catppuccin',
         globalstatus = true,
         component_separators = { left = '', right = '' },
         section_separators = { left = '', right = '' },
      },
      extensions = {
         'nvim-tree',
      },
   },
   config = true,
}
