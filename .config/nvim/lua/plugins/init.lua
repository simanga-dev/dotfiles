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
  'preservim/vim-pencil',
  'amadeus/vim-convert-color-to',
  'wsdjeg/calendar.nvim',
  'brenoprata10/nvim-highlight-colors',
  {
    'sourcegraph/amp.nvim',
    branch = 'main',
    lazy = false,
    opts = { auto_start = true, log_level = 'info' },
  },

  { 'ellisonleao/dotenv.nvim', opts = {} },

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
  {
    'gennaro-tedesco/nvim-jqx',
    event = { 'BufReadPost' },
    ft = { 'json', 'yaml' },
  },

  { 'mistricky/codesnap.nvim', tag = 'v2.0.0' },
}
