local set_hl = vim.api.nvim_set_hl
local colors = require('catppuccin.palettes').get_palette 'macchiato'

set_hl(0, 'IndentBlanklineChar', { fg = colors.surface0 })
set_hl(0, 'IndentBlanklineContextChar', { fg = colors.overlay1 })

require('indent_blankline').setup {
   char = '▏',
   show_current_context = true,
   show_current_context_start = true,
}
