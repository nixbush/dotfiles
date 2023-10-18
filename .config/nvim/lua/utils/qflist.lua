local M = {}

M.toggle_quickfix = function()
   local fn = vim.fn
   if fn.empty(fn.filter(fn.getwininfo(), 'v:val.quickfix')) == 1 then
      vim.cmd 'copen'
   else
      vim.cmd 'cclose'
   end
end

M.toggle_loclist = function()
   local fn = vim.fn
   if fn.empty(fn.filter(fn.getwininfo(), 'v:val.loclist')) == 1 then
      vim.cmd 'lopen'
   else
      vim.cmd 'lclose'
   end
end

return M
