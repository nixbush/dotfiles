require('nvim-treesitter.configs').setup {
   incremental_selection = {
      enable = true,
      keymaps = {
         init_selection = 'gnn',
         node_incremental = 'grn',
         scope_incremental = 'grc',
         node_decremental = 'grm',
      },
   },
   highlight = {
      enable = true,
      disable = function(_, buf)
         local max_filesize = 1000 * 1024 -- 1MB
         local ok, stats =
         pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
         if ok and stats and stats.size > max_filesize then
            return true
         end
      end,
   },
   autopairs = {
      enable = true,
   },
}
