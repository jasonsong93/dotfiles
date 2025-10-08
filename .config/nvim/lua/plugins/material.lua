return {
  'marko-cerovac/material.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.material_style = "deep ocean"
  end,
  opts = {},
  config = function(_, opts)
    require('material').setup(opts)
    vim.cmd('colorscheme material')
  end,
}
