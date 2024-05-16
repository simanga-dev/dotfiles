return {
  'quarto-dev/quarto-nvim',
  dependencies = {
    'jmbuhr/otter.nvim',
  },
  config = function()
    require('quarto').setup()
  end,
}
