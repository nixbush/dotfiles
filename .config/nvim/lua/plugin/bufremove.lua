return {
   'echasnovski/mini.bufremove',
   init = function()
      vim.keymap.set('n', 'Q', function()
         local buflisted = vim.fn.getbufinfo { buflisted = 1 }
         if vim.bo.buftype ~= '' or vim.bo.filetype ~= '' then
            MiniBufremove.delete()
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
   event = 'UIEnter',
}
