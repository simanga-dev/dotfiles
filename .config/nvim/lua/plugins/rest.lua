return {
  'rest-nvim/rest.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'http')
    end,
  },
  config = function()
    require('rest-nvim').setup {
      result = {
        split = {
          horizontal = false,
          in_place = false,
        },
      },
    }
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'httpResult',
      callback = function()
        require('utils.sidebar').close_others 'rest'
      end,
    })
  end,
}
