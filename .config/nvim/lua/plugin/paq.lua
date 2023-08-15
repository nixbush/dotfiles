---------------------------------
-- Plugins
---------------------------------
local packages = {
   'savq/paq-nvim',
   'nvim-lua/plenary.nvim',
   'nvim-tree/nvim-web-devicons',
   'lewis6991/gitsigns.nvim',

   -- LSP
   'neovim/nvim-lspconfig',
   'hrsh7th/nvim-cmp',
   'hrsh7th/cmp-path',
   'hrsh7th/cmp-buffer',
   'hrsh7th/cmp-nvim-lsp',
   'hrsh7th/cmp-nvim-lsp-signature-help',
   'dcampos/cmp-snippy',
   'dcampos/nvim-snippy',
   -- 'mfussenegger/nvim-dap',
   -- 'rcarriga/nvim-dap-ui',
   'nvimdev/guard.nvim',

   -- Quality of Life
   'windwp/nvim-autopairs',
   'numToStr/Comment.nvim',
   'nvim-telescope/telescope.nvim',
   'christoomey/vim-tmux-navigator',
   'nvim-tree/nvim-tree.lua',

   -- Themes
   { 'catppuccin/nvim', as = 'catppuccin' },
   {
      'nvim-treesitter/nvim-treesitter',
      run = function()
         vim.cmd.TSUpdateSync()
      end,
   },
   'rebelot/heirline.nvim',
   'willothy/nvim-cokeline',
   'lukas-reineke/indent-blankline.nvim'
}

---------------------------------
-- Bootstrapper
---------------------------------
local path = vim.fn.stdpath 'data' .. '/site/pack/paqs/opt/paq-nvim'
local installed = vim.fn.empty(vim.fn.glob(path)) == 0
if not installed then
   vim.fn.system {
      'git',
      'clone',
      '--depth=1',
      'https://github.com/savq/paq-nvim.git',
      path,
   }
end
vim.cmd.packadd 'paq-nvim'

local paq = require 'paq'
paq(packages)

if not installed then
   paq.install()
end
