---------------------------------
-- Mapping specific settings
---------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

---------------------------------
-- Set keymaps
---------------------------------
local map = vim.keymap.set

-- Save, quit and load
map('n', 'Q', function() -- Close buffers
   local buflisted = vim.fn.getbufinfo { buflisted = 1 }
   local cur_winnr, cur_bufnr = vim.fn.winnr(), vim.fn.bufnr()

   -- auto-quit
   if vim.bo.buftype ~= '' then
      vim.cmd 'confirm q'
      return
   end

   if #buflisted < 2 then
      vim.cmd 'confirm qall'
      return
   end

   -- buffer movement
   for _, winid in ipairs(vim.fn.getbufinfo(cur_bufnr)[1].windows) do
      vim.cmd(string.format('%d wincmd w', vim.fn.win_id2win(winid)))
      vim.cmd(cur_bufnr == buflisted[#buflisted].bufnr and 'bp' or 'bn')
   end
   vim.cmd(string.format('%d wincmd w', cur_winnr))

   -- terminal management
   local is_terminal = vim.fn.getbufvar(cur_bufnr, '&buftype') == 'terminal'
   vim.cmd(is_terminal and 'bd! #' or 'silent! confirm bd #')
end)
map('n', '<leader>q', '<cmd>confirm qall<cr>')
map('n', 'E', function() -- Window close
   if #vim.api.nvim_list_wins() > 1 then
      vim.cmd 'q'
   else
      print 'Cannot close last window'
   end
end)
map('n', 'W', vim.cmd.write)
map('n', 'S', vim.cmd.source)

-- Move between buffers and tabs
map('n', 'L', vim.cmd.bnext)
map('n', 'H', vim.cmd.bprev)
map('n', '<C-l>', vim.cmd.tabn)
map('n', '<C-h>', vim.cmd.tabp)

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

-- Search but lock cursor in the middle
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')

-- Join lines but better
map('n', 'J', 'mzJ`z')

-- Clear search highlight
map('n', '<leader>c', vim.cmd.nohlsearch)

-- Terminal escape
map('t', '<A-ESC>', '<C-\\><C-n><Esc>')

-- Quickfix list
map('n', ']f', '<cmd>cnext<cr>')
map('n', '[f', '<cmd>cprev<cr>')
map('n', 'gq', function() -- Toggle quickfix
   local f = vim.fn
   if f.empty(f.filter(f.getwininfo(), 'v:val.quickfix')) == 1 then
      vim.cmd 'copen'
   else
      vim.cmd 'cclose'
   end
end)
map('n', 'gl', function() -- Toggle loclist
   local f = vim.fn
   if f.empty(f.filter(f.getwininfo(), 'v:val.loclist')) == 1 then
      vim.cmd 'lopen'
   else
      vim.cmd 'lclose'
   end
end)
