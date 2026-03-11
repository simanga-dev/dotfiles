return {
  'stevearc/overseer.nvim',
  opts = {
    strategy = {
      'terminal',
      auto_scroll = false,
    },
    -- height = 20,
    task_list = {
      max_height = { 50, 0.5 },
      --   height = 20,
      direction = 'bottom',
    },
  },
  keys = {
    {
      '<leader>or',
      function()
        vim.cmd [[OverseerRun]]
      end,
      desc = '[OR] Oversee Run',
    },
    {
      '<leader>ot',
      function()
        vim.cmd [[OverseerToggle]]
      end,
      desc = '[OT] Oversee Toggle',
    },
  },
}
