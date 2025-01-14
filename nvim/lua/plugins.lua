-- Setup lazy.nvim
return {
	{ "rose-pine/neovim", as = "rose-pine" },
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
}
