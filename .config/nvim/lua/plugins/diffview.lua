return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<leader>gH',
      function()
        vim.cmd [[ DiffviewFileHistory <CR> ]]
      end,
      desc = 'Open diff view history',
    },
  },
}
