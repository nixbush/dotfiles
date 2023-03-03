local M = {}

M.init = function()
   vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeFindFileToggle)

   local augroup = vim.api.nvim_create_augroup('NvimTreeCustom', {})
   vim.api.nvim_clear_autocmds { group = augroup }

   local open_nvim_tree = function(data)
      local directory = vim.fn.isdirectory(data.file) == 1
      if not directory then
         return
      end
      vim.cmd.cd(data.file)
      require('nvim-tree.api').tree.open()
   end

   vim.api.nvim_create_autocmd(
      { 'VimEnter' },
      { group = augroup, callback = open_nvim_tree }
   )
end

M.config = function()
   require('nvim-tree').setup {
      disable_netrw = true,
      hijack_netrw = true,
      view = {
         centralize_selection = true,
      },
      renderer = {
         add_trailing = true,
         group_empty = true,
         highlight_git = true,
         indent_markers = {
            enable = true,
         },
      },
      hijack_directories = {
         enable = true,
         auto_open = true,
      },
      diagnostics = {
         enable = true,
         icons = {
            hint = ' ',
            info = ' ',
            warning = ' ',
            error = ' ',
         },
      },
      actions = {
         change_dir = { enable = false },
      },
   }
end

return M
