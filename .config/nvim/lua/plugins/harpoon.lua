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
      '<C-e>',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = '[T] Harpoon Menu',
    },
    {
      '<C-h>',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = '[T] Harpoon GoTo 1',
    },
    {
      '<C-t>',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = '[T] Harpoon GoTo 2',
    },
    {
      '<C-n>',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = '[T] Harpoon GoTo 3',
    },
    {
      '<C-s>',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = '[T] Harpoon GoTo 2',
    },
    {
      '<leader>>',
      function()
        require('harpoon'):list():next()
      end,
      desc = '[T] Harpoon GoTo 3',
    },
    {
      '<leader><',
      function()
        require('harpoon'):list():prev()
      end,
      desc = '[T] Harpoon GoTo 2',
    },
  },
  event = 'VeryLazy',
  branch = 'harpoon2',
  opts = {},
}
