return {
  'nvim-treesitter/nvim-treesitter',
  -- dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  -- commit = '8ada8faf2fd5a74cc73090ec856fa88f34cd364b',
  branch = 'main',
  build = ':TSUpdate',
  init = function()
    local ensureInstalled = {
      'lua',
      'python',
      'javascript',
      'typescript',
      'tsx',
      'html',
      'css',
      'json',
      'yaml',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
      'query',
      'bash',
      'regex',
      'c',
      'cpp',
      'go',
      'rust',
      'sql',
      'http',
    }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim
      .iter(ensureInstalled)
      :filter(function(parser)
        return not vim.tbl_contains(alreadyInstalled, parser)
      end)
      :totable()
    require('nvim-treesitter').install(parsersToInstall)
  end,
  config = function()
    require('nvim-treesitter').setup {
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
