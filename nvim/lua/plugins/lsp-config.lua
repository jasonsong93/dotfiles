return {
	-- Set up Mason and Mason LSP Config
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup(
				{
					-- Define the lsps you want to install, mason-lspconfig will handle
					ensure_installed = { "lua_ls" }
				})
		end
	},
	-- Set up neovim to use the above configured LSPs
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			-- Define the servers you want nvim to use
			lspconfig.lua_ls.setup({})
			vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})
		end
	},
	{
		"seblj/roslyn.nvim",
		ft = "cs",
		opts = {
			-- your configuration comes here; leave empty for default settings
		}
	}
}
