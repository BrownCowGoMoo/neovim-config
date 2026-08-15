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

	local function is_within_value(query, intable)
		for _, item in ipairs(intable) do
			if query == item then
				return true
			end
		end
		return false
	end

	local function is_within_keys(query, intable)
		for item, _ in pairs(intable) do
			if query == item then
				return true
			end
		end
		return false
	end

	local function attach_lsp(buffer, lang)
		if not vim.treesitter.language.add(lang) then return end
		vim.treesitter.start(buffer, lang)
	end


	local fname_pname = {
		lua = 'lua_ls',
		python = 'pyright',
	}

	local language_servers = {
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' },
					},
				},
			},
		},
		stylua = {},
		pyright = {},
	}

	local function enable_language_server(server, language_servers)
		vim.lsp.config(server, language_servers[server])
		vim.lsp.enable(server)
	end




	local available_parsers = require('nvim-treesitter').get_available()
	vim.api.nvim_create_autocmd('FileType', {
		callback = function(event)

			local filetype, buffer = event.match, event.buf
			local lang = vim.treesitter.language.get_lang(filetype)
			if not lang then
				print(('No language parser was found for filetype: %s'):format(filetype))
				return
			end

			local installed_parsers = require('nvim-treesitter').get_installed()
			if is_within_value(lang, installed_parsers) then
				attach_lsp(buffer, lang)
			end


			if is_within_keys(lang, fname_pname) then
				enable_language_server(fname_pname[lang], language_servers)
			else
				print(('No language server found for language: %s'):format(lang))
			end
		end,
	})

end
