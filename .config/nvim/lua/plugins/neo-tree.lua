local icon = require 'icons'
return {
  'nvim-neo-tree/neo-tree.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 2000, -- make sure to load this before all the other start plugins
  branch = 'v3.x',
  dependencies = {
    'nvim-neo-tree/neo-tree.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  -- opts = {
  -- hijack_netrw_behavior = 'open_current',
  -- use_popups_for_input = false, -- force use v
  --
  -- window = {
  --   position = 'current',
  --   mappings = {
  --     -- Disable neotree's fuzzy finder on `/`, it's annoying when I just want to jump to something I see
  --     ['/'] = 'noop',
  --     ['f'] = 'noop',
  --     ['#'] = 'noop',
  --   },
  -- },
  -- default_component_configs = {
  --   git_status = {
  --     symbols = icon.symbols,
  --   },
  -- },
  -- },
  keys = {
    -- {
    --   '<leader>e',
    --   function()
    --     vim.cmd [[ Neotree <CR> ]]
    --   end,
    --   desc = 'Launch File explore',
    -- },
  },
}
