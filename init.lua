
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
	-- Makes neovim share the clipboard when yanking text
	vim.opt.clipboard = 'unnamedplus'

	vim.opt.hidden = true

	vim.opt.smartcase = true
	vim.opt.ignorecase = true

	vim.opt.scrolloff = 10

	-- Auto command that highlights text when coppied
		vim.api.nvim_create_autocmd('TextYankPost', {
		group = vim.api.nvim_create_augroup('CopyPasteText', { clear = true }),
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
		end,
	})
end
