return {
   'catppuccin/nvim',
   name = 'catppuccin',
   priority = 1000,
   lazy = false,
   config = function ()
      require('catppuccin').setup {
         flavour = 'macchiato',
         custom_highlights = function(colors)
            return {
               IndentLineChar = { fg = colors.surface0 },
               IndentLineContextChar = { fg = colors.overlay1 },
            }
         end,
         dim_inactive = {
            enabled = true,
         }
      }
      vim.cmd 'colorscheme catppuccin'
   end
}
