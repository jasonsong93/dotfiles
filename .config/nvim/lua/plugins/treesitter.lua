return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
    require("telescope").load_extension("ui-select")
  end,
}
