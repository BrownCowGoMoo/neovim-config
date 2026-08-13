

do
	vim.pack.add({'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/nvim-telescope/telescope.nvim'})

	require('telescope').setup()

	local tele = require('telescope.builtin')
	vim.keymap.set('n', '<leader>sf', tele.find_files, { desc = 'find files' })
	vim.keymap.set('n', '<leader>sg', tele.live_grep, { desc = 'live grep' })
	vim.keymap.set('n', '<leader>sh', tele.help_tags, { desc = 'seach help' })
end



