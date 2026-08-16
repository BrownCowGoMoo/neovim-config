
--  ================================================================================
--  BASIC OPTIONS
--  ================================================================================
do
	vim.loader.enable()

	vim.g.mapleader = ' '
	vim.g.maplocalleader = ' '
	vim.g.have_nerd_font = true

	vim.opt.number = true
	vim.opt.relativenumber = true

	vim.opt.mouse = 'a'

	vim.opt.autochdir = false

	vim.opt.autoread = true
	vim.opt.autowrite = true
	vim.opt.backup = false

	vim.opt.splitbelow = true
	vim.opt.splitright = true

	vim.opt.breakindent = true
	vim.opt.copyindent = true
	vim.opt.autoindent = true
	vim.opt.wrap = false

	vim.opt.cursorcolumn = false
	vim.opt.cursorline = true
	vim.opt.signcolumn = 'yes'

	vim.opt.errorbells = false

	vim.opt.hidden = true

	vim.opt.smartcase = true
	vim.opt.ignorecase = true

	vim.opt.scrolloff = 10

	-- Adds highlighting over yanked text
	vim.api.nvim_create_autocmd('TextYankPost', {
		group = vim.api.nvim_create_augroup('YankText', { clear = true }),
		callback = function()
			vim.hl.on_yank()
		end,
	})

	-- Basic diagnostic config
	vim.diagnostic.config({
		severity_sort = true,
		update_in_insert = false,
		float = { border = 'rounded', source = 'if_many' },
		underline = { severity = { min = vim.diagnostic.severity.WARN } },

		virtual_text = true
	})
end

--  ================================================================================
--  PACKAGE HANDLING
--  ================================================================================

do
	local function install_package(name, command, path)
		local buildResults = vim.system(command, { cwd = path }):wait()
		if buildResults.code ~= 0 then
			local stderr = buildResults.stderr or ''
			local stdout = buildResults.stdout or ''
			local output = stderr ~= '' and stderr or stdout
			if output == '' then output = 'No output from package build' end
			vim.notify(('There was an issue of the build of the package: %s\noutput" %s'):format(name, output))
		end
	end

	vim.api.nvim_create_autocmd('PackChanged', {
		callback = function(event)
			local name = event.data.spec.name
			local type = event.data.kind
			local path = event.data.path

			if type ~= 'install' and type ~= 'update' then return end

			if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
				install_package(name, { 'make' }, path)
				return
			end

			if name == 'nvim-treesitter' then
				vim.cmd 'TSUpdate'
			end
		end,
	})

	require('browncow.telescope')
	require('browncow.oil')
	require('browncow.lsp.lsp')
end

