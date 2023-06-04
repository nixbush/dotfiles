local map = vim.keymap.set

vim.g.tmux_navigator_no_mappings = 1 -- use my own mappings
map({ 'n', 'i', 't' }, '<A-h>', '<cmd>TmuxNavigateLeft<cr>')
map({ 'n', 'i', 't' }, '<A-j>', '<cmd>TmuxNavigateDown<cr>')
map({ 'n', 'i', 't' }, '<A-k>', '<cmd>TmuxNavigateUp<cr>')
map({ 'n', 'i', 't' }, '<A-l>', '<cmd>TmuxNavigateRight<cr>')
map({ 'n', 'i', 't' }, '<A-{>', '<cmd>TmuxNavigatePrevious<cr>')
map({ 'n', 'i', 't' }, '<A-;>', '<cmd>call system("tmux send-keys M-\\;")<cr>')
