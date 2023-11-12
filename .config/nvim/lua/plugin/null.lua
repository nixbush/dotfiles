return {
   'nvimtools/none-ls.nvim',
   main = 'null-ls',
   config = function()
      local nls = require 'null-ls'
      nls.setup {
         sources = {
            nls.builtins.formatting.clang_format,
            nls.builtins.formatting.stylua,
            nls.builtins.diagnostics.clang_check,
         },
      }
   end,
}
