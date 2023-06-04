require('snippy').setup {
   mappings = {
      is = {
         ['<C-l>'] = 'expand_or_advance',
         ['<C-h>'] = 'previous',
      },
      nx = {
         ['<C-e>'] = 'cut_text',
      },
   },
}
