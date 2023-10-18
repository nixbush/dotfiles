---------------------------------
-- Mapping specific settings
---------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

---------------------------------
-- Set keymaps
---------------------------------
local map = vim.keymap.set

-- Better up and down
map(
   { 'n', 'x' },
   'j',
   "v:count == 0 ? 'gj' : 'j'",
   { expr = true, silent = true }
)
map(
   { 'n', 'x' },
   'k',
   "v:count == 0 ? 'gk' : 'k'",
   { expr = true, silent = true }
)

-- Buffers
map('n', 'W', vim.cmd.write)
map('n', 'Q', vim.cmd.bdelete)
map('n', 'S', vim.cmd.source)
map('n', 'E', '<cmd>confirm qall!<cr>')
map('n', 'L', vim.cmd.bnext)
map('n', 'H', vim.cmd.bprev)

-- Tabs
map('n', '<C-n>', vim.cmd.tabnew)
map('n', '<C-q>', vim.cmd.tabclose)
map('n', '<C-l>', vim.cmd.tabnext)
map('n', '<C-h>', vim.cmd.tabprevious)

-- Move to other windows
map('n', '<A-h>', '<C-w>h')
map('n', '<A-j>', '<C-w>j')
map('n', '<A-k>', '<C-w>k')
map('n', '<A-l>', '<C-w>l')
map('i', '<A-h>', '<Esc><C-w>h')
map('i', '<A-j>', '<Esc><C-w>j')
map('i', '<A-k>', '<Esc><C-w>k')
map('i', '<A-l>', '<Esc><C-w>l')
map('t', '<A-h>', '<C-\\><C-n><C-w>h')
map('t', '<A-j>', '<C-\\><C-n><C-w>j')
map('t', '<A-k>', '<C-\\><C-n><C-w>k')
map('t', '<A-l>', '<C-\\><C-n><C-w>l')

-- Resize windows
map('n', '<A-Left>', '<C-w><')
map('n', '<A-Down>', '<C-w>-')
map('n', '<A-Up>', '<C-w>+')
map('n', '<A-Right>', '<C-w>>')
map('t', '<A-Left>', '<C-\\><C-n><C-w><')
map('t', '<A-Down>', '<C-\\><C-n><C-w>-')
map('t', '<A-Up>', '<C-\\><C-n><C-w>+')
map('t', '<A-Right>', '<C-\\><C-n><C-w>>')

-- Move current or selected lines vertically
map('n', '<C-j>', 'mz:m+<cr>`z')
map('n', '<C-k>', 'mz:m-2<cr>`z')
map('i', '<C-j>', '<Esc>:m +1<cr>a')
map('i', '<C-k>', '<Esc>:m -2<cr>a')
map('v', '<C-j>', ":m'>+<cr>`<my`>mzgv`yo`z")
map('v', '<C-k>', ":m'<-2<cr>`>my`<mzgv`yo`z")

-- Indentations
map('n', '>', '>>')
map('n', '<', '<<')
map('v', '>', '>gv')
map('v', '<', '<gv')

-- Clear search highlight
map('n', '<ESC>', '<cmd>noh<cr><esc>')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true })
map('n', 'N', "'nN'[v:searchforward]", { expr = true })
map('x', 'N', "'nN'[v:searchforward]", { expr = true })
map('o', 'N', "'nN'[v:searchforward]", { expr = true })

-- Quickfix list
map('n', ']f', '<cmd>cnext<cr>')
map('n', '[f', '<cmd>cprev<cr>')
map(
   'n',
   '<leader>qf',
   require('utils.qflist').toggle_quickfix,
   { desc = 'Toggle Quickfix List' }
)
map(
   'n',
   '<leader>ql',
   require('utils.qflist').toggle_loclist,
   { desc = 'Toggle Location List' }
)
