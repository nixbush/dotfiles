return {
   'catppuccin/nvim',
   name = 'catppuccin',
   lazy = false,
   priority = 1000,
   config = function()
      require('catppuccin').setup {
         flavour = 'macchiato',
         custom_highlights = function(colors)
            return {
               IndentLineChar = { fg = colors.surface0 },
               IndentLineContextChar = { fg = colors.overlay1 },
            }
         end,
         integrations = {
            markdown = true,
            dashboard = true,
         },
      }
      vim.cmd 'colorscheme catppuccin'
   end,
}
