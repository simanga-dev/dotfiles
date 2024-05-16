-- return {
--   'rest-nvim/rest.nvim',
--   dependencies = { 'nvim-lua/plenary.nvim' },
--   commit = '1ce984c',
--   keys = {
--     {
--       '<leader>rr',
--       function()
--         require('rest-nvim').run()
--       end,
--       desc = 'call the current line in curl',
--     },
--   },
--   config = function()
--     require('rest-nvim').setup {
--       result = {
--         show_statistics = {
--           {
--             'time_total',
--             title = 'Total Time: ',
--             type = 'time',
--           },
--         },
--       },
--     }
--   end,
-- }

return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000,
    config = true,
  },
  {
    'rest-nvim/rest.nvim',
    ft = 'http',
    opts = {
      encode_url = false,
      keybinds = {
        {
          '<localleader>rr',
          '<cmd>Rest run<cr>',
          'Run request under the cursor',
        },
        {
          '<localleader>rl',
          '<cmd>Rest run last<cr>',
          'Re-run latest request',
        },
      },
    },
    dependencies = { 'luarocks.nvim' },
    config = function(_, opts)
      require('rest-nvim').setup(opts)
    end,
  },
}
