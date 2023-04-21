local M = {}

--------------------------------
-- Async formatting
--------------------------------
M.async_format = function(bufnr)
   bufnr = bufnr or vim.api.nvim_get_current_buf()

   vim.lsp.buf_request(
      bufnr,
      'textDocument/formatting',
      vim.lsp.util.make_formatting_params {},
      function(err, res, ctx)
         if err then
            local err_msg = type(err) == 'string' and err or err.message
            -- you can modify the log message / level (or ignore it completely)
            vim.notify('formatting: ' .. err_msg, vim.log.levels.WARN)
            return
         end

         -- don't apply results if buffer is unloaded or has been modified
         if
            not vim.api.nvim_buf_is_loaded(bufnr)
            or vim.api.nvim_buf_get_option(bufnr, 'modified')
         then
            return
         end

         if res then
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            vim.lsp.util.apply_text_edits(
               res,
               bufnr,
               client and client.offset_encoding or 'utf-16'
            )
            vim.api.nvim_buf_call(bufnr, function()
               vim.cmd 'silent noautocmd update'
            end)
         end
      end
   )
end

--------------------------------
-- Range formatting
--------------------------------
M.range_format = function()
   local old_func = vim.go.operatorfunc
   _G.op_func_formatting = function()
      local start = vim.api.nvim_buf_get_mark(0, '[')
      local finish = vim.api.nvim_buf_get_mark(0, ']')
      -- vim.lsp.buf.range_formatting({}, start, finish)
      vim.lsp.buf.format {
         filter = function(client)
            return client.name == 'null-ls'
         end,
         range = { start, finish },
      }
      vim.go.operatorfunc = old_func
      _G.op_func_formatting = nil
   end
   vim.go.operatorfunc = 'v:lua.op_func_formatting'
   vim.api.nvim_feedkeys('g@', 'n', false)
end

--------------------------------
return M
