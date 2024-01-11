-- Setup Mason to automatically install LSP servers
require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- PHP
require('lspconfig').intelephense.setup({ capabilities = capabilities })

-- Vue, JavaScript, TypeScript
require('lspconfig').volar.setup({
  capabilities = capabilities,
  -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
  -- This drastically improves the responsiveness of diagnostic updates on change
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

-- require('lspconfig').tsserver.setup({})

-- Tailwind CSS
require('lspconfig').tailwindcss.setup({
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end,
    capabilities = capabilities,
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
  })

-- Golang
require('lspconfig').gopls.setup({
    capabilities = capabilities,
    filetypes = { 'go' },
  })

-- HTML
require('lspconfig').html.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'templ' },
})

-- Templ
require('lspconfig').templ.setup({
  capabilities = capabilities,
  filetypes = { 'templ' },
})

-- JSON
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})

-- null-ls
require('null-ls').setup({
  sources = {
    require('null-ls').builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.json' }) or utils.root_has_file({ '.eslintrc.js' })
      end,
    }),
    require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
    require('null-ls').builtins.formatting.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.json' }) or utils.root_has_file({ '.eslintrc.js' })
      end,
    }),
    require('null-ls').builtins.formatting.prettierd,
  },
})

require('mason-null-ls').setup({ automatic_installation = true })

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
vim.keymap.set('n', '<Leader>dd', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<Leader>rs', ':LspRestart<CR>')
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

-- Commands
-- vim.api.nvim_create_user_command('Format', vim.lsp.buf.format { async = true }, {})
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = true,
  }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
