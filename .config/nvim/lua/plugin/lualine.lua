return {
   'nvim-lualine/lualine.nvim',
   event = 'VeryLazy',
   config = true,
   opts = {
      options = {
         theme = 'catppuccin',
         globalstatus = true,
         component_separators = { left = '', right = '' },
         section_separators = { left = '', right = '' },
         disabled_filetypes = { statusline = { 'starter' } }
      },
   },
}
