return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c",
      "c_sharp",
      "javascript",
      "html",
      "cpp",
      "css",
      "csv",
      "lua",
      "rust",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
    },
    sync_install = false,
    auto_install = true,  -- enable this or disable this as necessary 
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
