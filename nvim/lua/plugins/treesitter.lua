return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ts_configs = require("nvim-treesitter.configs")
    ts_configs.setup({
      auto_installed = true,
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "go",
        "javascript",
        "typescript",
        "html",
        "php",
        -- "php_only",
        "bash",
        -- "blade",
        "templ",
        "tsx",
        "astro",
        "scss",
        "css",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade", -- local path or git repo
        files = { "src/parser.c" },                       -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        branch = "main",                                  -- default branch in case of git repo if different from master
      },
      filetype = "blade",                                 -- if filetype does not match the parser name
    }
    vim.filetype.add({
      pattern = {
        [".*%.blade%.php"] = "blade",
      },
    })
    local bladeGrp
    vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.blade.php",
      group = bladeGrp,
      callback = function()
        vim.opt.filetype = "blade"
      end,
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.templ",
      callback = function()
        vim.cmd("TSBufEnable highlight")
      end,
    })
  end,
}
