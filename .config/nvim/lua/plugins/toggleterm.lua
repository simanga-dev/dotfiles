return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    {
      '<leader>t',
      function()
        vim.cmd [[ ToggleTerm ]]
      end,
      desc = '[T] ToggleTeam',
    },
  },
  opts = {
    size = 15,
  },
}
