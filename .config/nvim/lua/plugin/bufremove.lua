return {
   'echasnovski/mini.bufremove',
   init = function() -- please don't look at this mess
      vim.keymap.set('n', 'Q', function()
         local buflisted = vim.fn.getbufinfo { buflisted = 1 }
         if not vim.bo.buflisted then
            vim.cmd 'q'
            return
         end
         if vim.bo.buftype ~= '' or vim.bo.filetype ~= '' then
            if vim.bo.buftype == 'terminal' then
               MiniBufremove.delete(0, true)
            else
               MiniBufremove.delete()
            end
            return
         end
         if #buflisted < 2 then
            vim.cmd 'confirm qall'
            return
         end
      end)
   end,
   config = true,
   version = false,
   event = 'VeryLazy',
}
