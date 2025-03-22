local set = vim.opt

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.number = true
set.shortmess = "I"
set.scrolloff = 9
set.cursorline = true
set.termguicolors = true

local keymap = vim.keymap
keymap.set('n', 's', '<C-w>', { remap = true })
keymap.set('n', '<A-k>', '<cmd>bn<CR>', { remap = true })
keymap.set('n', '<A-j>', '<cmd>bp<CR>', { remap = true })
keymap.set('n', '<C-w>c', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>', { remap = true })
keymap.set('n', '<A-down>', 'ddp', { remap = true })
keymap.set('n', '<A-up>', 'ddkP', { remap = true })
keymap.set('n', '<C-/>', 'gcc', { remap = true })
keymap.set('n', '<C-s>', '<cmd>w<CR>', { remap = true })
keymap.set('i', '<C-s>', '<cmd>w<CR><Esc>', { remap = true })
keymap.set('v', '<C-/>', 'gc', { remap = true })
keymap.set('i', '<C-BS>', '<Esc>ldbi', { remap = true })
keymap.set('n', '<C-A>', '0ggvG$', { remap = true })
keymap.set('i', '<C-A>', '<Esc>0ggvG$', { remap = true })
return {}
