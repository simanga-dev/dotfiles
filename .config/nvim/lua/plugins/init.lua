return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-repeat',
  'tpope/vim-endwise',
  'tpope/vim-eunuch',
  'monkoose/matchparen.nvim',
  'tpope/vim-capslock',
  'tpope/vim-dotenv',
  'andymass/vim-matchup',
  'cohama/lexima.vim',
  'kovetskiy/sxhkd-vim',
  'b0o/schemastore.nvim',
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
  -- 'jamespeapen/Nvim-R',
  'norcalli/nvim-colorizer.lua',
  'preservim/vim-pencil',
  'amadeus/vim-convert-color-to',
  {
    'yorickpeterse/nvim-tree-pairs',
    opts = {},
  },
  'brenoprata10/nvim-highlight-colors',
  'nvim-lua/lsp_extensions.nvim',
  'Hoffs/omnisharp-extended-lsp.nvim',
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
  --   opts = {
  --     transparent_background = true,
  --   },
  --   config = function(_, opts)
  --     require('tokyodark').setup(opts) -- calling setup is optional
  --     vim.cmd [[colorscheme tokyodark]]
  --   end,
  -- },

  -- {
  --   'rebelot/kanagawa.nvim',
  --   config = function()
  --     require('kanagawa').setup {
  --       theme = 'dragon', -- Load "wave" theme when 'background' option is not set
  --     }
  --     vim.cmd [[ colorscheme kanagawa ]]
  --   end,
  -- },
  -- {
  --   'ellisonleao/gruvbox.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = 'dark' -- or "light" for light mode
  --     vim.cmd [[colorscheme gruvbox]]
  --   end,
  --   opts = {},
  -- },
  --
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      -- style = 'night',
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
      transparent = true,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd [[colorscheme tokyonight]]
    end,
  },

  -- {
  --   'projekt0n/github-nvim-theme',
  --   config = function()
  --     require('github-theme').setup {
  --       -- ...
  --     }
  --     vim.cmd 'colorscheme github_dark'
  --   end,
  -- },
  --

  -- {
  --   'gbprod/nord.nvim',
  --   config = function()
  --     require('nord').setup {
  --       -- ...
  --     }
  --     vim.cmd [[colorscheme nord]]
  --   end,
  -- },

  { 'rebelot/kanagawa.nvim', lazy = false },
  'MunifTanjim/nui.nvim',
  'stevearc/dressing.nvim',
}
