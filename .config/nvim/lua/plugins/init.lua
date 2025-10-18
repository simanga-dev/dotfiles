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
  'brenoprata10/nvim-highlight-colors',
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
}
