return {
  'ofirgall/open.nvim',
  event = 'VeryLazy',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {},
  keys = {
    {
      '<leader>O',
      function()
        require('open').open_cword()
      end,
      desc = 'Launch ChatGPT',
    },
  },
}
