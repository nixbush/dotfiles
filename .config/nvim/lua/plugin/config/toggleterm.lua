local M = {}

M.init = function()
   local map = vim.keymap.set
   map('n', '<A-|>', '<C-\\><C-n><cmd>ToggleTerm direction=vertical<cr>')
   map('t', '<A-|>', '<C-\\><C-n><cmd>ToggleTerm direction=vertical<cr>')
   map('n', '<A-\\>', '<C-\\><C-n><cmd>ToggleTerm direction=horizontal<cr>')
   map('t', '<A-\\>', '<C-\\><C-n><cmd>ToggleTerm direction=horizontal<cr>')
end

M.config = function()
   local colors = require('dracula').colors()
   require('toggleterm').setup {
      size = function(term)
         if term.direction == 'horizontal' then
            return 15
         elseif term.direction == 'vertical' then
            return vim.o.columns * 0.3
         end
      end,
      open_mapping = nil,
      on_open = function()
         local winset = vim.api.nvim_win_set_option
         winset(0, 'signcolumn', 'no')
      end,
      shade_terminals = false,
      close_on_exit = false,
      highlights = {
         Normal = {
            guifg = colors.fg,
            guibg = colors.black,
         },
         NormalFloat = {
            link = 'Normal',
         },
         FloatBorder = {
            link = 'NormalFloat',
         },
      },
      float_opts = {
         border = 'single',
         highlights = {
            border = 'FloatBorder',
            background = 'NormalFloat',
         },
      },
   }
end

return M
