return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-repeat',
  'tpope/vim-endwise',
  'tpope/vim-eunuch',
  'rhysd/committia.vim',
  'monkoose/matchparen.nvim',
  'tpope/vim-capslock',
  'tpope/vim-dotenv',
  'andymass/vim-matchup',
  'b0o/schemastore.nvim',
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
  'norcalli/nvim-colorizer.lua',
  'preservim/vim-pencil',
  'amadeus/vim-convert-color-to',
  {
    'yorickpeterse/nvim-tree-pairs',
    opts = {},
  },
  'brenoprata10/nvim-highlight-colors',
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup {}
    end,
  },
  -- {
  --   'tiagovla/tokyodark.nvim',
  --   priority = 1000,
  --   opts = {},
  --   config = function(_, opts)
  --     require('tokyodark').setup(opts) -- calling setup is optional
  --     vim.cmd [[colorscheme tokyodark]]
  --   end,
  -- },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require('tokyonight').setup(opts) -- calling setup is optional
      vim.cmd [[colorscheme tokyonight-night  ]]
    end,
  },

  { 'rebelot/kanagawa.nvim', lazy = false },
  'MunifTanjim/nui.nvim',
  'stevearc/dressing.nvim',
  {
    'gennaro-tedesco/nvim-jqx',
    event = { 'BufReadPost' },
    ft = { 'json', 'yaml' },
  },
}
