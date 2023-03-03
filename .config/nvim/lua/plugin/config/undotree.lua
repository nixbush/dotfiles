local M = {}

M.init = function()
   vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

   local g = vim.g
   g.undotree_WindowLayout = 3
   g.undotree_SplitWidth = 40
end

return M
