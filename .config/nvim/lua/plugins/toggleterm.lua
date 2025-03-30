return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    {
      '<leader>t',
      function()
        vim.cmd [[ ToggleTerm ]]
      end,
      desc = ' Toggle Terminal',
    },
  },
  opts = {
    size = 20,
  },
}
