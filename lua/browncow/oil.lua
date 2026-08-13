
vim.pack.add({'https://github.com/stevearc/oil.nvim'})
require('oil').setup()

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'open parent directory' })



