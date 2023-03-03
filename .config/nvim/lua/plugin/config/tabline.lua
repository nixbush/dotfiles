local M = {}

M.init = function()
   local map = vim.keymap.set
   map('n', 'H', vim.cmd.TablineBufferPrevious)
   map('n', 'L', vim.cmd.TablineBufferNext)
end

M.config = function()
   require('tabline').setup {
      enable = true,
      options = {
         max_bufferline_percent = nil,
         show_tabs_always = true,
         show_devicons = true,
         show_bufnr = false,
         show_filename_only = false,
         modified_icon = '[+] ',
         modified_italic = false,
         show_tabs_only = false,
      },
   }
end

return M
