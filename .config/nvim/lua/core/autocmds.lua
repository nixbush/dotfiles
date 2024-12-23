---------------------------------
-- Auto-run functions
---------------------------------
local mkdir_on_save = function()
   local dir = vim.fn.expand '<afile>:p:h'
   if dir:find '%l+://' == 1 then
      return
   end
   if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
   end
end

---------------------------------
-- Auto commands
---------------------------------
-- Setup new augroup
local augroup = vim.api.nvim_create_augroup('UserAutocmds', {})
vim.api.nvim_clear_autocmds {
   group = augroup,
}

-- Create missing directories when saving
vim.api.nvim_create_autocmd('BufWritePre', {
   group = augroup,
   callback = mkdir_on_save,
})
