return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  keys = {
    {
      '<C-q>',
      function()
        require('quicker').toggle()
      end,
      desc = 'toggle quickfix',
    },
  },
}
