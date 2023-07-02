require('dap-go').setup {
  -- Additional dap configurations can be added.
  -- dap_configurations accepts a list of tables where each entry
  -- represents a dap configuration. For more details do:
  -- :help dap-configuration
  dap_configurations = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "main.go",
    }
  },
  -- delve configurations
  delve = {
    -- time to wait for delve to initialize the debug session.
    -- default to 20 seconds
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    -- default to string "${port}" which instructs nvim-dap
    -- to start the process in a random available port
    port = "${port}"
  },
}
require('dapui').setup()
vim.keymap.set('n', '<leader>tb', ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>dc', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<leader>ut', ":lua require'dapui'.toggle()<CR>")
vim.keymap.set('n', '<leader>uc', ":lua require'dapui'.close()<CR>")
vim.keymap.set('n', '<leader>dt', ":lua require'dap'.terminate()<CR>")
