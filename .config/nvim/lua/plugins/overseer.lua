return {
  'stevearc/overseer.nvim',
  opts = {
    task_list = {
      direction = 'right',
      min_width = 80,
      max_width = 80,
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
        require('utils.sidebar').close_others 'overseer'
        vim.cmd [[OverseerToggle]]
      end,
      desc = '[OT] Oversee Toggle',
    },
  },
}
