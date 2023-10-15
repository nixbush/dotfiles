return {
   'lukas-reineke/indent-blankline.nvim',
   main = 'ibl',
   opts = {
      indent = {
         highlight = 'IndentLineChar',
         char = '▏',
      },
      scope = {
         enabled = true,
         highlight = 'IndentLineContextChar',
         char = '▏',
      },
      exclude = {
         filetypes = {
            'dashboard',
         },
      },
   },
   config = true,
   event = 'VeryLazy',
}
