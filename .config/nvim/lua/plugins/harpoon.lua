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
      '<C-f>',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = '[T] Harpoon Menu',
    },
    {
      '<C-b>',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = '[T] Harpoon GoTo 1',
    },
    {
      '<C-c>',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = '[T] Harpoon GoTo 2',
    },
    {
      '<C-d>',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = '[T] Harpoon GoTo 3',
    },
    {
      '<C-e>',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = '[T] Harpoon GoTo 2',
    },

    {
      '<C-c>',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = '[T] Harpoon GoTo 3',
    },
    {
      '<C-d>',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = '[T] Harpoon GoTo 2',
    },

    {
      '<leadereader>>',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = '[T] Harpoon GoTo 3',
    },
    {
      '<leader><',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = '[T] Harpoon GoTo 2',
    },
  },
  event = 'VeryLazy',
  branch = 'harpoon2',
  opts = {},
}

-- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
--
-- -- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
