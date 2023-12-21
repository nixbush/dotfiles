return {
   'mbbill/undotree',
   lazy = false,
   init = function ()
      vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<cr>')
   end
}
