require('catppuccin').setup {
   flavour = 'macchiato',
   background = {
      light = 'latte',
      dark = 'macchiato',
   },
   term_colors = true,
   custom_highlights = function(colors)
      return {
         DapBreakpoint = { fg = colors.red },
         DapBreakpointCondition = { fg = colors.mauve },
         DapLogPoint = { fg = colors.blue },
         DapStopped = { fg = colors.green },
         DapBreakpointRejected = { fg = colors.overlay0 },
      }
   end,
}

vim.cmd.colorscheme 'catppuccin-macchiato'
