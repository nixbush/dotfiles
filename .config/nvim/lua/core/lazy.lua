---------------------------------
-- Bootstrap lazy.nvim
---------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------------------------
-- Configure lazy.nvim
---------------------------------
require('lazy').setup('plugin', {
   defaults = {
      lazy = true
   },
   ui = {
      border = 'single',
   },
   change_detection = {
      notify = false,
   },
   performance = {
      rtp = {
         disabled_plugins = {
            'gzip',
            'matchit',
            -- 'matchparen',
            'netrwPlugin',
            'tarPlugin',
            'tohtml',
            'tutor',
            'zipPlugin',
            'rplugin',
            'man',
            'spellfile',
         },
      },
   },
})

---------------------------------
-- Mappings
---------------------------------
local map = vim.keymap.set
map('n', '<localleader>l', '<cmd>Lazy<cr>')
