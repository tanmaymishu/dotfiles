return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "tailwindcss", "html", "gopls", "templ", "intelephense" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities =
          require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react", "typescriptreact" },
        init_options = { userLanguages = { templ = "html" } },
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      })
      lspconfig.intelephense.setup({
        capabilities = capabilities,
        filetypes = { "php" },
      })
      -- lspconfig.htmx.setup({
      -- 	capabilities = capabilities,
      -- 	filetypes = { "html", "templ" },
      -- })
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

      vim.filetype.add({ extension = { templ = "templ" } })

      lspconfig.templ.setup({
        capabilities = capabilities,
      })

      -- Command to toggle inline diagnostics
      vim.api.nvim_create_user_command("DiagnosticsToggleVirtualText", function()
        local current_value = vim.diagnostic.config().virtual_text
        if current_value then
          vim.diagnostic.config({ virtual_text = false })
        else
          vim.diagnostic.config({ virtual_text = true })
        end
      end, {})

      -- Command to toggle diagnostics
      vim.api.nvim_create_user_command("DiagnosticsToggle", function()
        local current_value = vim.diagnostic.is_disabled()
        if current_value then
          vim.diagnostic.enable()
        else
          vim.diagnostic.disable()
        end
      end, {})
      -- Function to check if a floating dialog exists and if not
      -- then check for diagnostics under the cursor
      function OpenDiagnosticIfNoFloat()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
          if vim.api.nvim_win_get_config(winid).zindex then
            return
          end
        end
        -- THIS IS FOR BUILTIN LSP
        vim.diagnostic.open_float(0, {
          scope = "cursor",
          focusable = false,
          close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "WinLeave",
          },
        })
      end

      -- Show diagnostics under the cursor when holding position
      vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold" }, {
        pattern = "*",
        command = "lua OpenDiagnosticIfNoFloat()",
        group = "lsp_diagnostics_hold",
      })
      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set({ "n", "v" }, "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<Leader>dd", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
      vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")
      vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<Leader>rs", ":LspRestart<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>ud", ":DiagnosticsToggleVirtualText<CR>")
      -- Command
      vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = false,
        float = {
          source = true,
        },
      })
      -- Sign configuration
      vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
    end,
  },
}
