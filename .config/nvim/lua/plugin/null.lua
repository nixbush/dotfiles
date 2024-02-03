local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
return {
   'nvimtools/none-ls.nvim',
   main = 'null-ls',
   config = function()
      local nls = require 'null-ls'
      nls.setup {
         sources = {
            nls.builtins.formatting.clang_format,
            nls.builtins.formatting.stylua,
            -- nls.builtins.diagnostics.clang_check,
         },
         on_attach = function(client, bufnr)
            if client.supports_method 'textDocument/formatting' then
               vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
               vim.api.nvim_create_autocmd('BufWritePre', {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                     vim.lsp.buf.format { bufnr = bufnr }
                  end,
               })
            end
         end,
      }
   end,
   ft = { 'c', 'cpp', 'lua' },
}
