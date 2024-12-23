---@diagnostic disable: undefined-global
local map_split = function(buf_id, lhs, direction)
   local rhs = function()
      local new_target_window
      vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
         vim.cmd(direction .. ' split')
         new_target_window = vim.api.nvim_get_current_win()
      end)
      MiniFiles.set_target_window(new_target_window)
   end
   local desc = 'Split ' .. direction
   vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

return {
   'echasnovski/mini.files',
   version = false,
   config = function()
      require('mini.files').setup {
         windows = {
            preview = true,
         },
      }

      vim.api.nvim_create_autocmd('User', {
         pattern = 'MiniFilesBufferCreate',
         callback = function(args)
            local buf_id = args.data.buf_id
            map_split(buf_id, 'gs', 'belowright horizontal')
            map_split(buf_id, 'gv', 'belowright vertical')
         end,
      })
   end,
   opts = {
   },
   keys = {
      { '<leader>e', '<cmd>lua MiniFiles.open()<cr>', desc = 'Manipulate Files' }
   },
}
