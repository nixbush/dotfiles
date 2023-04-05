local M = {}

M.config = function()
   --------------------------------
   -- Setup constants
   --------------------------------
   local nls = require 'null-ls'
   local formatting = nls.builtins.formatting
   local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
   local utils = require 'utils'

   --------------------------------
   -- Configure null-ls
   --------------------------------
   nls.setup {
      debug = false,
      on_attach = function(client, bufnr)
         if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePost', {
               group = augroup,
               buffer = bufnr,
               callback = function()
                  vim.lsp.buf.format { bufnr = bufnr, timeout_ms = 5000 }
               end,
            })
         end
      end,
      sources = {
         formatting.stylua,
         formatting.clang_format,
         formatting.rustfmt,
         formatting.mdformat.with {
            extra_args = { '--wrap', vim.wo.colorcolumn, '--number' },
         },
      },
   }
end

return M
