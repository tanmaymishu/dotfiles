return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "prettierd" },
      })
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
        ensure_installed = { "lua_ls", "tsserver", "astro", "tailwindcss", "html", "gopls", "templ", "intelephense", "eslint" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local function filter(arr, fn)
        if type(arr) ~= "table" then
          return arr
        end

        local filtered = {}
        for k, v in pairs(arr) do
          if fn(v, k, arr) then
            table.insert(filtered, v)
          end
        end

        return filtered
      end

      local function filterReactDTS(value)
        return string.match(value.targetUri, 'react/[^/]+/index.d.ts') == nil
      end

      local capabilities =
          require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      -- local util = require 'lspconfig.util'
      -- local function get_typescript_server_path(root_dir)
      --   local global_ts = '/opt/homebrew/lib/node_modules/typescript/lib'
      --   -- Alternative location if installed as root:
      --   -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
      --   local found_ts = ''
      --   local function check_dir(path)
      --     found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
      --     if util.path.exists(found_ts) then
      --       return path
      --     end
      --   end
      --   if util.search_ancestors(root_dir, check_dir) then
      --     return found_ts
      --   else
      --     return global_ts
      --   end
      -- end

      -- lspconfig.volar.setup {
      --   on_new_config = function(new_config, new_root_dir)
      --     new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
      --   end,
      --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
      -- }
      -- lspconfig.volar.setup {
      --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
      -- }
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(_client, buffer)
          local function goto_source_definition()
            local position_params = vim.lsp.util.make_position_params()
            vim.lsp.buf.execute_command({
              command = "_typescript.goToSourceDefinition",
              arguments = { vim.api.nvim_buf_get_name(0), position_params.position },
            })
          end
          local opts = { buffer = buffer }
          vim.keymap.set("n", "<leader>gz", goto_source_definition, opts)
        end,
        handlers = {
          ['textDocument/definition'] = function(err, result, method, ...)
            if vim.tbl_islist(result) and #result > 1 then
              local filtered_result = filter(result, filterReactDTS)
              return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
            end

            vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
          end,
          ["workspace/executeCommand"] = function(_err, result, ctx, _config)
            if ctx.params.command ~= "_typescript.goToSourceDefinition" then
              return
            end
            if result == nil or #result == 0 then
              return
            end
            vim.lsp.util.jump_to_location(result[1], "utf-8")
          end,
        }
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react", "typescriptreact" },
        init_options = { userLanguages = { templ = "html" } },
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "templ", "php" },
      })
      lspconfig.intelephense.setup({
        capabilities = capabilities,
        filetypes = { "php", "blade" },
      })
      lspconfig.astro.setup({
        capabilities = capabilities,
        filetypes = { "astro" },
      })
      local root_file = {
        '.eslintrc',
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json',
        'eslint.config.js',
        'eslint.config.mjs',
        'eslint.config.cjs',
        'eslint.config.ts',
        'eslint.config.mts',
        'eslint.config.cts',
      }
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        root_dir = function(fname)
          root_file = lspconfig.util.insert_package_json(root_file, 'eslintConfig', fname)
          return lspconfig.util.root_pattern(unpack(root_file))(fname)
        end,
        filetypes = { "html", "markdown", "vue", "astro", "javascript", "typescript", "typescriptreact", "javascriptreact" },
      })
      -- lspconfig.htmx.setup({
      -- 	capabilities = capabilities,
      -- 	filetypes = { "html", "templ" },
      -- })
      lspconfig.gopls.setup({})

      vim.filetype.add({ extension = { templ = "templ" } })

      lspconfig.templ.setup({
        capabilities = capabilities,
      })

      -- go install github.com/nametake/golangci-lint-langserver@latest
      if not lspconfig.golangcilsp then
        lspconfig.golangcilsp = {
          default_config = {
            cmd = { 'golangci-lint-langserver' },
            root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
            init_options = {
              command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json", "--issues-exit-code=1" },
            }
          },
        }
      end
      lspconfig.golangci_lint_ls.setup {
        filetypes = { 'go', 'gomod' }
      }

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
