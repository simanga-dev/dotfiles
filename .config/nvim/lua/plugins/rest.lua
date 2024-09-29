-- return {
--   {
--     'vhyrro/luarocks.nvim',
--     priority = 1000,
--     config = true,
--   },
--   {
--     'rest-nvim/rest.nvim',
--     ft = 'http',
--     opts = {
--       encode_url = false,
--       keybinds = {
--         {
--           '<localleader>rr',
--           '<cmd>Rest run<cr>',
--           'Run request under the cursor',
--         },
--         {
--           '<localleader>rl',
--           '<cmd>Rest run last<cr>',
--           'Re-run latest request',
--         },
--       },
--     },
--     dependencies = { 'luarocks.nvim' },
--     config = function(_, opts)
--       require('rest-nvim').setup(opts)
--     end,
--   },
-- }

return {
  'rest-nvim/rest.nvim',
}
