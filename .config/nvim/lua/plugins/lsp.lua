return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "prettier",
        "black",
        "csharpier",
        "eslint_d",
        "flake8",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "omnisharp",
        "yamlls",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = function(client, bufnr)
              local opts = { noremap = true, silent = true, buffer = bufnr }
              -- Jump to references
              vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
              -- Optional: other useful mappings
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
              vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
              vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            end,
          })
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },
}
