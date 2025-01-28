return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  -- commit = '8ada8faf2fd5a74cc73090ec856fa88f34cd364b',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = 'all', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gn', -- set to `false` to disable one of the mappings
          node_incremental = 'gn',
          scope_incremental = 'false',
          node_decremental = 'gN',
        },
      },
    }
  end,
}
