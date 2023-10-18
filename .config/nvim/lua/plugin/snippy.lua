return {
   'dcampos/nvim-snippy',
   opts = {
      mappings = {
         is = {
            ['<C-l>'] = 'expand_or_advance',
            ['<C-h>'] = 'previous',
         },
         nx = {
            ['<C-e>'] = 'cut_text',
         },
      },
   },
   config = true,
   event = 'InsertEnter',
}
