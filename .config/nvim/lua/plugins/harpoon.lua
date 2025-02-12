return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
      desc = '[T] Harpoon Add',
    },
    {
      '<leader>hm',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = '[T] Harpoon Menu',
    },
    {
      '<leader>1',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = '[T] Harpoon GoTo 1',
    },
    {
      '<leader>2',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = '[T] Harpoon GoTo 2',
    },
    {
      '<leader>3',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = '[T] Harpoon GoTo 3',
    },
    {
      '<leader>4',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = '[T] Harpoon GoTo 2',
    },
  },
  event = 'VeryLazy',
  branch = 'harpoon2',
  opts = {},
}
