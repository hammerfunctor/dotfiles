vim.g.mapleader = " "
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap
local opt = {noremap =  true, silent = true}

-- scroll nine lines
map('n', '<C-u>', '9k', opt)
map('n', '<C-d>', '9j', opt)

-- buffer operations
--map('n', 'gn', ':bn<cr>', opt)
--map('n', 'gp', ':bp<cr>', opt)
--map('n', 'gd', ':bd<cr>', opt)

-- jump between windows
map('n', '<A-j>', '<C-w>j', opt)
map('n', '<A-k>', '<C-w>k', opt)
map('n', '<A-h>', '<C-w>h', opt)
map('n', '<A-l>', '<C-w>l', opt)

-- comment codes in visual mode
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)

-- open and close windows
map('n', 'sv', ':vsp<CR>', opt)
map('n', 'sh', ':sp<CR>', opt)
map('n', 'sc', '<C-w>c', opt) -- close current
map('n', 'so', '<C-w>o', opt) -- close others

-- resize windows
map("n", "s.", ":vertical resize +20<CR>", opt)
map("n", "s,", ":vertical resize -20<CR>", opt)
map("n", "s=", "<C-w>=", opt)
map("n", "sj", ":resize +10<CR>",opt)
map("n", "sk", ":resize -10<CR>",opt)
