local M = {}

M.init = function()
   vim.api.nvim_set_var('dap_program', nil)

   -- Change debugging signs
   local signs = {
      Breakpoint = '',
      BreakpointCondition = '',
      LogPoint = '',
      Stopped = '',
      BreakpointRejected = '',
   }
   for type, icon in pairs(signs) do
      local hl = 'Dap' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
   end

   -- Keymaps
   local map = vim.keymap.set
   local dap = require 'dap'
   map('n', '<leader>dd', function()
      dap.continue()
      print 'Always remember to build before debugging!'
   end)
   map('n', '<leader>dq', dap.terminate)
   map('n', '<leader>dj', dap.step_over)
   map('n', '<leader>dl', dap.step_into)
   map('n', '<leader>dk', dap.step_out)
   map('n', '<leader>db', dap.toggle_breakpoint)
   map('n', '<leader>dB', dap.set_breakpoint)
   map('n', '<leader>di', function()
      dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
   end)
   map('n', '<leader>dr', dap.repl.open)
   map('n', '<leader>dD', dap.run_last)
end

M.config = function()
   local dap = require 'dap'

   dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode',
      name = 'lldb',
   }

   dap.configurations.c = {
      {
         name = 'Launch',
         type = 'lldb',
         request = 'launch',
         program = function()
            if
               vim.g.dap_program == nil
               or vim.fn.filereadable(vim.fn.expand(vim.g.dap_program)) == 0
            then
               vim.ui.input({
                  prompt = 'Path to executable: ',
                  default = vim.fn.getcwd() .. '/',
                  completion = 'file',
               }, function(input)
                  vim.api.nvim_set_var('dap_program', input)
               end)
            end

            return vim.g.dap_program
         end,
         cwd = '${workspaceFolder}',
         stopOnEntry = false,
         args = {},
         -- runInTerminal = false,
      },
   }

   dap.configurations.cpp = dap.configurations.c
   dap.configurations.rust = dap.configurations.c

   -- dap-ui configuration
   local dapui = require 'dapui'
   dapui.setup()

   dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
   end
   dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
   end
   dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
   end
end

return M
