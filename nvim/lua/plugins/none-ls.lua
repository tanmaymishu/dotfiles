return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    null_ls.setup({
      sources = {
        require("none-ls.diagnostics.eslint_d"),
        formatting.prettierd.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "json",
            "yaml",
            "markdown",
          },
          extra_args = { "--print-width 120" },
        }),
      }
    })
  end,
}
