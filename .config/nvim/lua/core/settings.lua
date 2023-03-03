local o, g = vim.opt, vim.g

---------------------------------
-- Commands
---------------------------------
vim.cmd [[
filetype plugin indent on
colorscheme slate
syntax enable
]]

---------------------------------
-- Global variables
---------------------------------
g.loaded_netrw = true
g.loaded_netrwPlugin = true
g.vimsyn_embed = 'laf'

---------------------------------
-- Aesthetics
---------------------------------
o.cmdheight = 1
o.colorcolumn = '80'
o.cursorline = true
o.fillchars = {
   eob = ' ',
   fold = ' ',
   foldopen = '',
   foldsep = ' ',
   foldclose = '',
}
o.foldenable = false
o.foldminlines = 1
o.foldnestmax = 3
o.foldtext =
   [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'…'.trim(getline(v:foldend)).' ('.(v:foldend - v:foldstart + 1).' lines)']]
o.foldmethod = 'indent'
o.guifont = { 'UbuntuMono Nerd Font', '14' }
o.number = true
o.shellpipe = '2>&1 | tee %s; exit ${pipestatus[1]}'
o.showmode = false
o.signcolumn = 'yes:1'
o.termguicolors = true
o.wrap = false

---------------------------------
-- General
---------------------------------
o.autowrite = true
o.clipboard = 'unnamedplus'
o.errorformat = '%E%f line %l in %m,%C%m,%Z'
o.exrc = false
o.hidden = true
o.iskeyword:append '-'
o.joinspaces = false
o.mouse = 'a'
o.scrolloff = 8
o.secure = true
o.sessionoptions =
   'blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal'
o.sidescrolloff = 8
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.updatetime = 200
o.virtualedit = 'block'
o.undofile = true
o.completeopt = 'menu,menuone,noselect'

---------------------------------
-- Search
---------------------------------
o.ignorecase = true
o.inccommand = 'nosplit'
o.smartcase = true
o.wildignorecase = true
o.wildignore = { '.git/*' }

---------------------------------
-- Tabs
---------------------------------
o.tabstop = 3
o.expandtab = true
o.shiftwidth = 3
o.softtabstop = -1

---------------------------------
-- Shortmess
---------------------------------
o.shortmess:append {
   A = true,
   I = true,
   W = true,
   c = true,
   m = true,
}
