return {
   'stevearc/overseer.nvim',
   config = function()
      local ov = require 'overseer'
      ov.setup()

      ---------------------------------
      -- Overseer Tasks
      ---------------------------------
   end,
   keys = {
      { '<leader>oo', '<cmd>OverseerQuickAction<cr>' }
   },
   event = 'VeryLazy',
}
