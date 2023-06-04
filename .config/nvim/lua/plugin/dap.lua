local dap = require 'dap'
local dapui = require 'dapui'

---------------------------------
--  UI Changes
---------------------------------
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

---------------------------------
--  Mappings
---------------------------------
local map = vim.keymap.set
map('n', '<leader>dd', dap.continue)
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
map('n', '<leader>de', dapui.eval)

---------------------------------
-- Helper functions
---------------------------------
local get_prog = function()
   if
      vim.g.dap_program == vim.NIL
      or vim.g.dap_program == nil
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
end

---------------------------------
-- Debugger Configuration
---------------------------------
dap.adapters.cppdbg = {
   id = 'cppdbg',
   type = 'executable',
   command = vim.fn.stdpath 'data'
      .. '/tools/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
   {
      name = 'Launch file',
      type = 'cppdbg',
      request = 'launch',
      program = get_prog,
      cwd = '${workspaceFolder}',
      stopAtEntry = false,
   },
   {
      name = 'Attach to gdbserver :1234',
      type = 'cppdbg',
      request = 'launch',
      MIMode = 'gdb',
      miDebuggerServerAddress = 'localhost:1234',
      miDebuggerPath = '/usr/bin/gdb',
      cwd = '${workspaceFolder}',
      program = get_prog,
   },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

---------------------------------
-- Debugger UI Configuration
---------------------------------
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
