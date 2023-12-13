return {
   'lukas-reineke/indent-blankline.nvim',
   main = 'ibl',
   event = 'VeryLazy',
   config = true,
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
   },
}
