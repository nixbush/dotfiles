local M = {}

M.init = function()
   local map = vim.keymap.set
end

M.config = function()
   local dap = require 'dap'

   dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb',
      name = 'lldb',
   }

   dap.configurations.cpp = {
      {
         name = 'Launch',
         type = 'lldb',
         request = 'launch',
         program = function()
            return vim.fn.input(
               'Path to executable: ',
               vim.fn.getcwd() .. '/',
               'file'
            )
         end,
         cwd = '${workspaceFolder}',
         stopOnEntry = false,
         args = {},
         -- runInTerminal = false,
      },
   }

   dap.configurations.cpp = dap.configurations.c
   dap.configurations.rust = dap.configurations.c
end

return M
