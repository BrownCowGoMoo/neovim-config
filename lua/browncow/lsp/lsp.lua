do
	vim.pack.add({
		'{https://github.com/neovim/nvim-lspconfig',
		'https://github.com/mason-org/mason.nvim',
		'https://github.com/mason-org/mason-lspconfig.nvim',
		'https://github.com/nvim-treesitter/nvim-treesitter',
	})

	require('mason').setup()
	require('mason-lspconfig').setup({
		automatic_enable = false
	})


