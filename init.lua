
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

	vim.opt.errorbells = false

	-- Makes neovim share the clipboard when yanking text
	vim.opt.clipboard = 'unnamedplus'

	vim.opt.hidden = true

	vim.opt.smartcase = true
	vim.opt.ignorecase = true
end



