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

	local function is_within(item, tbl)
		for _, parser in ipairs(tbl) do
			if item == parser then
				return true
			end
		end
		return false
	end

	local name_server_config = {
		lua = {
			server = 'lua_ls',
			config = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
						},
					},
				},
			},
		},
	}

	vim.api.nvim_create_autocmd('FileType', {
		callback = function(event)
			local filetype, buffer = event.match, event.buf
			local language = vim.treesitter.language.get_lang(filetype)
			if not language then
				print(('No language parser found for filetype: %s'):format(filetype))
				return
			end
			local installed_parsers = require('nvim-treesitter').get_installed()
			if is_within(language, installed_parsers) then
				if not vim.treesitter.language.add(language) then return end
				vim.treesitter.start(buffer, language)
			end
			if not name_server_config[language] then
				print(('No language %s found in the given table'):format(language))
				return
			end
			if not name_server_config[language]['server'] then
				print(('No config found in the given table for language %s'):format(language))
				return
			end
			local server = name_server_config[language]['server']
			local config = name_server_config[language]['config']
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end,
	})
end


