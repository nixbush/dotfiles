local generic_opts = {
   border = 'single',
   win_opts  = {
      winblend = 0,
   }
}

return {
   'stevearc/overseer.nvim',
   cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
   },
   config = true,
   opts = {
      dap = false,
      form = generic_opts,
      confirm = generic_opts,
      task_win = generic_opts,
      help_win = generic_opts,
   }
}
