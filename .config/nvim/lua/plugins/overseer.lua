return {
  'stevearc/overseer.nvim',
  opts = {
    strategy = {
      'terminal',
      auto_scroll = false,
    },
    -- height = 20,
    task_list = {
      min_height = 0.5,
      max_height = 0.5,
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
