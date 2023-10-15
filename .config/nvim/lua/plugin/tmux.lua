return {
   'christoomey/vim-tmux-navigator',
   init = function()
      vim.g.tmux_navigator_no_mappings = 1
   end,
   keys = {
      { '<A-h>', ':<C-U>TmuxNavigateLeft<cr>', silent = true },
      { '<A-j>', ':<C-U>TmuxNavigateDown<cr>', silent = true },
      { '<A-k>', ':<C-U>TmuxNavigateUp<cr>', silent = true },
      { '<A-l>', ':<C-U>TmuxNavigateRight<cr>', silent = true },
   },
}
