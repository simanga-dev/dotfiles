-- return {
--   'numToStr/Comment.nvim',
--   dependencies = {
--     'nvim-treesitter/nvim-treesitter',
--     'JoosepAlviste/nvim-ts-context-commentstring',
--   },
--   event = 'VeryLazy',
--   config = function()
--     require('ts_context_commentstring').setup {
--       enable_autocmd = false,
--     }
--     require('Comment').setup {
--       pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
--     }
--   end,
-- }

-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
return {
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
  },
}
