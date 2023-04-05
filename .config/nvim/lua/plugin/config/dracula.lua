local M = {}

M.config = function()
   vim.cmd.colorscheme 'dracula'

   -- Custom colors
   local color = require('dracula').colors()
   local hl = vim.api.nvim_set_hl
   hl(0, 'NormalFloat', { fg = color.white, bg = color.menu })
   hl(0, 'VertSplit', { fg = color.selection })
   hl(0, 'FoldColumn', { fg = color.comment })
   hl(0, 'FloatBorder', { fg = color.white, bg = color.menu })
   hl(0, 'ColorColumn', { bg = color.menu })
   hl(0, 'StatusLineNC', { fg = color.fg, bg = color.selection })
   hl(0, 'StatusLine', { fg = color.selection, bg = color.selection })
   hl(0, 'TabLine', { fg = color.fg, bg = color.bg })
   hl(0, 'TabLineSel', { fg = color.fg, bg = color.menu })
   hl(0, 'TabLineFill', { fg = color.fg, bg = color.black })

   hl(0, 'TelescopePromptBorder', { fg = color.white, bg = color.menu })
   hl(0, 'TelescopeResultsBorder', { fg = color.white, bg = color.menu })
   hl(0, 'TelescopePreviewBorder', { fg = color.white, bg = color.menu })
   hl(0, 'TelescopeSelection', { fg = color.white, bg = color.selection })
   hl(0, 'TelescopeMultiSelection', { fg = color.purple, bg = color.selection })
   hl(0, 'TelescopeNormal', { fg = color.fg, bg = color.menu })
   hl(0, 'TelescopeMatching', { fg = color.green })
   hl(0, 'TelescopePromptPrefix', { fg = color.purple, bg = color.menu })

   hl(0, 'LspSignatureActiveParameter', { fg = color.bg, bg = color.orange })

   hl(0, 'DapBreakpoint', { fg = color.red })
   hl(0, 'DapBreakpointCondition', { fg = color.orange })
   hl(0, 'DapLogPoint', { fg = color.cyan })
   hl(0, 'DapStopped', { fg = color.green })
   hl(0, 'DapBreakpointRejected', { fg = color.comment })
end

return M
