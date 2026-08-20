

do
	vim.pack.add({'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
	'https://github.com/nvim-telescope/telescope.nvim'})

	require('telescope').setup()

	local tele = require('telescope.builtin')
	vim.keymap.set('n', '<leader>sf', tele.find_files, { desc = 'find files' })
	vim.keymap.set('n', '<leader>sg', tele.live_grep, { desc = 'live grep' })
	vim.keymap.set('n', '<leader>sh', tele.help_tags, { desc = 'seach help' })


	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('tele-lsp-attach', { clear = true }),
		callback = function(event)
			local buffer = event.buf
			vim.keymap.set('n', '<leader>grr', tele.lsp_references, { buffer = buffer })
			vim.keymap.set('n', '<leader>gri', tele.lsp_implementations, { buffer = buffer })
			vim.keymap.set('n', '<leader>grd', tele.lsp_definitions, { buffer = buffer })
			vim.keymap.set('n', '<leader>gO', tele.lsp_document_symbols, { buffer = buffer })
			vim.keymap.set('n', '<leader>grt', tele.lsp_type_definitions, { buffer = buffer})
		end
	})


end



