return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "c_sharp" },
			indent = { enable = true},
			highlight = {enable = true},
		})
	end
}
