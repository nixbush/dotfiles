---------------------------------
-- Plugins
---------------------------------
local ide_fts = { 'c', 'cpp', 'lua', 'rust' } -- Filetypes with IDE functionality
local plugins = {
   'nvim-tree/nvim-web-devicons',
   'nvim-lua/plenary.nvim',

   ---------------------------------
   -- IDE-like functionality
   ---------------------------------
   {
      'neovim/nvim-lspconfig',
      ft = ide_fts,
      config = function()
         require('plugin.config.lspconfig').config()
      end,
   },
   {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
         'hrsh7th/cmp-path',
         'hrsh7th/cmp-buffer',
         'hrsh7th/cmp-nvim-lsp',
         'hrsh7th/cmp-nvim-lsp-signature-help',
         'dcampos/cmp-snippy',
      },
      config = function()
         require('plugin.config.cmp').config()
      end,
   },
   {
      'dcampos/nvim-snippy',
      ft = 'snippets',
      event = 'InsertEnter',
      config = function()
         require('plugin.config.nvim_snippy').config()
      end,
   },
   {
      'jose-elias-alvarez/null-ls.nvim',
      event = 'VeryLazy',
      config = function()
         require('plugin.config.null_ls').config()
      end,
   },
   {
      'mfussenegger/nvim-dap',
      dependencies = {
         'rcarriga/nvim-dap-ui',
      },
      init = function()
         require('plugin.config.dap').init()
      end,
      config = function()
         require('plugin.config.dap').config()
      end,
   },

   --------------------------------
   -- Quality of Life
   --------------------------------
   {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
         require('nvim-autopairs').setup { check_ts = true }
      end,
   },
   {
      'numToStr/Comment.nvim',
      keys = {
         'gc',
         { 'gc', mode = 'v' },
         { 'gb', mode = 'v' },
      },
      config = function()
         require('Comment').setup()
      end,
   },
   {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      init = function()
         require('plugin.config.telescope').init()
      end,
      config = function()
         require('plugin.config.telescope').config()
      end,
   },
   {
      'akinsho/toggleterm.nvim',
      cmd = 'ToggleTerm',
      init = function()
         require('plugin.config.toggleterm').init()
      end,
      config = function()
         require('plugin.config.toggleterm').config()
      end,
   },
   {
      'nvim-tree/nvim-tree.lua',
      init = function()
         require('plugin.config.nvim_tree').init()
      end,
      config = function()
         require('plugin.config.nvim_tree').config()
      end,
   },
   {
      'mbbill/undotree',
      cmd = 'UndotreeToggle',
      init = function()
         require('plugin.config.undotree').init()
      end,
   },
   {
      'ThePrimeagen/harpoon',
      keys = {
         '<leader>hh',
         '<leader>ht',
         '<leader>hu',
         ']h',
         '[h',
      },
      config = function()
         require('plugin.config.harpoon').init()
         require('plugin.config.harpoon').config()
      end,
   },

   --------------------------------
   -- Aesthetics
   --------------------------------
   {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      ft = ide_fts,
      config = function()
         require('plugin.config.treesitter').config(ide_fts)
      end,
   },
   {
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
      config = function()
         require('plugin.config.blankline').config()
      end,
   },
   {
      'Mofiqul/dracula.nvim',
      lazy = false,
      priority = 1000,
      config = function()
         require('plugin.config.dracula').config()
      end,
   },
   {
      'nvim-lualine/lualine.nvim',
      config = function()
         require('lualine').setup {}
      end,
   },
   {
      'kdheepak/tabline.nvim',
      config = function()
         require('tabline').setup()
      end,
   },
}

---------------------------------
-- Bootstrap
---------------------------------
local lazy_path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
   vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazy_path,
   }
end
vim.opt.rtp:prepend(lazy_path)

require('lazy').setup(plugins, {
   lockfile = vim.fn.stdpath 'data' .. '/lazy/lazy-lock.json',
   install = {
      colorscheme = { 'dracula' },
   },
   ui = {
      border = 'single',
   },
})
