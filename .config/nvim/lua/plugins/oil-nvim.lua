return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 2000, -- make sure to load this before all the other start plugins
  opts = {
    win_options = {
      signcolumn = 'yes',
    },
  },
  keys = {
    {
      '<leader>e',
      function()
        vim.cmd [[ Oil ]]
      end,
      desc = 'Launch File explore',
    },
  },
  -- Optional dependencies
}
