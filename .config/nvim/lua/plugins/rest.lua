return {
  'rest-nvim/rest.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'http')
    end,
  },
  opts = {
    rocks = {
      enabled = true,
      hererocks = true, -- Use isolated Lua environment instead of system luarocks
    },
  },
  build = function()
    -- Ensure hererocks is used for building
    require('rest-nvim').setup {
      rocks = {
        enabled = true,
        hererocks = true,
      },
    }
  end,
}
