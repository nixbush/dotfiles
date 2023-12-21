return {
   'stevearc/dressing.nvim',
   event = 'VeryLazy',
   config = true,
   opts = {
      input = {
         default_prompt = '> ',
         border = 'single',
      },
      select = {
         backend = 'telescope',
      },
   },
}
