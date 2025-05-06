return {
  'Kurren123/mssql.nvim',
  opts = {},
  -- optional. You also need to call set_keymaps (see below)
  dependencies = { 'folke/which-key.nvim' },
  config = function()
    require('mssql').setup()
    require('mssql').set_keymaps '<leader>ms'
  end,
}
