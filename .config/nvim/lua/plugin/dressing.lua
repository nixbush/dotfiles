return {
   'stevearc/dressing.nvim',
   opts = {
      input = {
         default_prompt = '> ',
         border = 'single',
      },
      select = {
         backend = 'telescope',
      },
   },
   config = true,
   event = 'VeryLazy',
}
