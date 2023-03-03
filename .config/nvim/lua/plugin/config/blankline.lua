local M = {}

M.config = function()
   require('indent_blankline').setup {
      char = '▏',
      context_char = '▏',
      filetype_exclude = {
         'help',
         'terminal',
         'startify',
         'packer',
         'startuptime',
         'dashboard',
         'NvimTree',
         'alpha',
         'lazy',
      },
      space_char_blankline = ' ',
      buftype_exclude = { 'terminal' },
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      show_current_context = true,
      show_current_context_start = false,
   }
end

return M
