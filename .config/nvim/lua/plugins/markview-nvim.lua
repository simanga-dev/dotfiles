-- return {
--   'OXY2DEV/markview.nvim',
--   dependencies = {
--     -- You may not need this if you don't lazy load
--     -- Or if the parsers are in your $RUNTIMEPATH
--     'nvim-treesitter/nvim-treesitter',
--
--     'nvim-tree/nvim-web-devicons',
--   },
-- }

return {
  'MeanderingProgrammer/markdown.nvim',
  main = 'render-markdown',
  opts = {},
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
}
